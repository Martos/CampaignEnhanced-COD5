const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'raw\\ui\\menudef.h');
const nsisPath = path.join(__dirname, 'CE_installer_nsis_script.nsi');

function updateNsisVersion(major, minor, patch) {
    try {
        if (!fs.existsSync(nsisPath)) {
            console.error(`File NSIS non trovato in: ${nsisPath}`);
            return;
        }

        const nsisData = fs.readFileSync(nsisPath, 'utf8');
        const nsisVersion = `${major}.${minor}.${patch}.0`;
        const nsisRegex = /(!define\s+PRODUCT_VERSION\s+")[^"]*(")/;

        if (nsisRegex.test(nsisData)) {
            const updatedNsisData = nsisData.replace(nsisRegex, `$1${nsisVersion}$2`);
            fs.writeFileSync(nsisPath, updatedNsisData, 'utf8');
            console.log(`NSIS aggiornato alla versione: ${nsisVersion}`);
        } else {
            console.error("Impossibile trovare la stringa '!define PRODUCT_VERSION' nel file NSIS.");
        }
    } catch (err) {
        console.error(`Errore durante l'aggiornamento del file NSIS: ${err.message}`);
    }
}

function incrementVersion() {
    try {
        if (!fs.existsSync(filePath)) {
            console.error(`File menudef.h not found: ${filePath}`);
            return;
        }

        const data = fs.readFileSync(filePath, 'utf8');
        const regex = /(#define\s+CE_VERSION\s+"DEV\s+)(\d+)\.(\d+)\.(\d+)(")/;
        const match = data.match(regex);

        if (match) {
            const prefix = match[1];
            const major = match[2];
            const minor = match[3];
            const patch = parseInt(match[4], 10);
            const suffix = match[5];

            const newPatch = patch + 1;
            const newVersionLine = `${prefix}${major}.${minor}.${newPatch}${suffix}`;

            const updatedData = data.replace(regex, newVersionLine);
            fs.writeFileSync(filePath, updatedData, 'utf8');

            console.log(`Set version in menudef.h: ${newVersionLine}`);

            updateNsisVersion(major, minor, newPatch);

        } else {
            console.error("Not found in menudef.h");
        }
    } catch (err) {
        console.error(`Error: ${err.message}`);
    }
}

incrementVersion();