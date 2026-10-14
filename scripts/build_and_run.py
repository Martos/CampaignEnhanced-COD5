import os
import subprocess
import threading
import tkinter as tk
from tkinter import scrolledtext, messagebox

class App:
    def __init__(self, root):
        self.runGameVar = tk.IntVar()

        self.root = root
        self.root.title("Campaign Enhanced Builder")
        self.root.geometry("1000x550")
        self.root.resizable(False, False)

        self.run_btn = tk.Button(root, text="Build", font=("Arial", 11, "bold"), bg="#4CAF50", fg="white", command=self.start_process_thread)
        self.run_btn.pack(pady=10, fill=tk.X, padx=20)

        frame = tk.Frame(root)
        frame.pack(anchor='w', padx=20, pady=0)

        self.runGameVar = tk.IntVar()
        c1 = tk.Checkbutton(frame, text='Run game', variable=self.runGameVar, onvalue=1, offvalue=0)
        c1.pack(side=tk.LEFT, padx=(0, 10))

        self.incVerVar = tk.IntVar()
        c2 = tk.Checkbutton(frame, text='Inc version', variable=self.incVerVar, onvalue=1, offvalue=0)
        c2.pack(side=tk.LEFT)

        self.log_area = scrolledtext.ScrolledText(root, wrap=tk.WORD, font=("Consolas", 10))
        self.log_area.pack(expand=True, fill=tk.BOTH, padx=20, pady=10)
        self.log_area.config(state=tk.DISABLED)

        self.log_area.tag_config("error", foreground="red")

    def log(self, message):
        self.log_area.config(state=tk.NORMAL)
        if "error" in message.lower():
            self.log_area.insert(tk.END, message + "\n", "error")
        else:
            self.log_area.insert(tk.END, message + "\n")
        self.log_area.see(tk.END)
        self.log_area.config(state=tk.DISABLED)

    def clear_logs(self):
        self.log_area.config(state=tk.NORMAL)
        self.log_area.delete("1.0", tk.END)
        self.log_area.config(state=tk.DISABLED)

    def start_process_thread(self):
        self.clear_logs()
        self.run_btn.config(state=tk.DISABLED)
        thread = threading.Thread(target=self.run_all_steps)
        thread.daemon = True
        thread.start()

    def run_command_with_output(self, cmd):
        process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='ignore')
        for line in process.stdout:
            self.log(line.rstrip())
        process.wait()
        return process.returncode

    def run_all_steps(self):
        try:
            self.log("=== CARICAMENTO CONFIGURAZIONE .env ===")
            if not os.path.exists(".env"):
                self.log("Errore: .env non trovato.")
                messagebox.showerror("Errore", ".env non trovato.")
                return

            env_vars = {}
            with open(".env", "r", encoding="utf-8", errors="ignore") as f:
                for line in f:
                    line = line.strip()
                    if line and not line.startswith("#") and "=" in line:
                        key, val = line.split("=", 1)
                        env_vars[key.strip()] = val.strip()

            codwaw_path = env_vars.get("CODWAW_PATH", "")
            workdir_path = env_vars.get("WORKDIR_PATH", "")
            linker_disk = env_vars.get("LINKER_DISK_PATH", "C:")
            language = env_vars.get("LANGUAGE", "english")
            localappdata = os.environ.get("LOCALAPPDATA", "")

            if self.incVerVar.get() == 1:
                self.log("\n--- INC VER ---")
                node_dir = os.path.join(workdir_path, "scripts")
                self.run_command_with_output(f'node "{node_dir}"\setVersion.js')

            # --- STEP 1: SYNC_WORKSPACE_FAST ---
            self.log("\n--- 1. SYNC_WORKSPACE_FAST ---")
            mod_dir = os.path.join(codwaw_path, "mods", "CampaignEnhanced")
            
            self.log(f"Rimozione e creazione directory: {mod_dir}")
            if os.path.exists(mod_dir):
                self.run_command_with_output(f'rmdir /s /q "{mod_dir}"')
            os.makedirs(mod_dir, exist_ok=True)

            def xcopy(src, dst):
                self.log(f"Copia da {src} a {dst}")
                self.run_command_with_output(f'xcopy "{src}" "{dst}" /Y /E /H /C /I')

            xcopy(os.path.join(workdir_path, "raw"), os.path.join(codwaw_path, "raw"))
            xcopy(os.path.join(workdir_path, "zone_source"), os.path.join(codwaw_path, "zone_source"))
            xcopy(os.path.join(workdir_path, "source_data"), os.path.join(codwaw_path, "source_data"))
            xcopy(os.path.join(workdir_path, "mods", "CampaignEnhanced"), mod_dir)

            # --- STEP 2: CAMPAIGN_ENHANCED_BUILD ---
            self.log("\n--- 2. CAMPAIGN_ENHANCED_BUILD ---")
            
            mod_csv_src = os.path.join(codwaw_path, "mods", "CampaignEnhanced", "mod.csv")
            mod_csv_dst = os.path.join(codwaw_path, "zone_source", "mod.csv")
            self.log(f"Copia mod.csv: {mod_csv_src} -> {mod_csv_dst}")
            self.run_command_with_output(f'copy /Y "{mod_csv_src}" "{mod_csv_dst}"')

            bin_path = os.path.join(codwaw_path, "bin")
            linker_exe = os.path.join(bin_path, "linker_pc.exe")
            cmd_linker = f'{linker_disk} && cd /d "{bin_path}" && "{linker_exe}" -nopause -language {language} -moddir CampaignEnhanced mod'
            self.log(f"Esecuzione linker: {cmd_linker}")
            self.run_command_with_output(cmd_linker)

            seven_zip = os.path.join(bin_path, "7za.exe")
            iwd_path = os.path.join(codwaw_path, "mods", "CampaignEnhanced", "CampaignEnhanced.iwd")
            sound_dir = os.path.join(codwaw_path, "mods", "CampaignEnhanced", "sound")
            weapons_dir = os.path.join(codwaw_path, "mods", "CampaignEnhanced", "weapons")
            cmd_7z = f'"{seven_zip}" a -tzip "{iwd_path}" "{sound_dir}" "{weapons_dir}"'
            self.log(f"Compressione IWD: {cmd_7z}")
            self.run_command_with_output(cmd_7z)

            dist_lang = os.path.join(workdir_path, "dist", language, "CampaignEnhanced")
            os.makedirs(dist_lang, exist_ok=True)

            mod_ff_src = os.path.join(codwaw_path, "zone", language, "mod.ff")
            mod_arena_src = os.path.join(codwaw_path, "mods", "CampaignEnhanced", "mod.arena")

            self.log("Copia file di build in dist...")
            self.run_command_with_output(f'copy /Y "{mod_ff_src}" "{dist_lang}"')
            self.run_command_with_output(f'copy /Y "{iwd_path}" "{dist_lang}"')
            self.run_command_with_output(f'copy /Y "{mod_arena_src}" "{dist_lang}"')

            appdata_mod = os.path.join(localappdata, "Activision", "CodWaW", "mods", "CampaignEnhanced")
            if os.path.exists(appdata_mod):
                self.run_command_with_output(f'rmdir /s /q "{appdata_mod}"')
            xcopy(dist_lang, appdata_mod)

            # --- STEP 3: RUN_GAME ---
            if self.runGameVar.get() == 1:
                self.log("\n--- 3. RUN_GAME ---")
                game_exe = os.path.join(codwaw_path, "CoDWaW_LanFixed.exe")
                cmd_game = f'{linker_disk} && cd /d "{codwaw_path}" && START "" "{game_exe}" +set fs_game "mods/CampaignEnhanced" +set r_fullscreen 0 +set r_mode "1280x720" +set developer 2 +set ui_showList 1 +exec "default_controller.cfg" +devmap oki3 +set developeruser 1 +set logfile 1'
                self.log(f"Avvio gioco: {cmd_game}")
                self.run_command_with_output(cmd_game)

            self.log("\n=== PROCESSO COMPLETATO CON SUCCESSO! ===")
            # messagebox.showinfo("Completato", "Tutti i processi sono stati eseguiti con successo!")
        except Exception as e:
            self.log(f"ERRORE: {str(e)}")
            messagebox.showerror("Errore", str(e))
        finally:
            self.run_btn.config(state=tk.NORMAL)

if __name__ == "__main__":
    root = tk.Tk()
    app = App(root)
    root.mainloop()
