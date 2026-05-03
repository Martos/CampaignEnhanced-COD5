const fs = require('fs');

MAJOR_VERSION = "DEV 0.92";

filecontent = []
async function main() {
    require('child_process').exec('git rev-parse HEAD', function(err, stdout) {
        fs.readFile('raw\\ui\\menudef.h', 'utf-8', function(err, data) {
            if (err) throw err;
    
            const arr = data.toString().replace(/\r\n/g,'\n').split('\n');
            if(arr[arr.length-1] == "")
                arr.pop();

            let newVersionLine = `#define CE_VERSION "${MAJOR_VERSION}.${stdout.substring(0,6).trim()}"`;

            arr[arr.length-1] = newVersionLine;

            filecontent = arr;
            write(`${MAJOR_VERSION}.${stdout.substring(0,6).trim()}`);
        });
    });
}

function write(version) {
    const file = fs.createWriteStream('raw\\ui\\menudef.h');
    file.on('error', (err) => {});
    filecontent.forEach((v) => {
        file.write(v + '\n');
    });
    file.end();

    console.log("Updated to: " + version);
}

main();