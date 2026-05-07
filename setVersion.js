const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'raw\\ui\\menudef.h');

function incrementVersion() {
    try {

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

            console.log(`Set version: ${newVersionLine}`);
        } else {
            console.error("File not found");
        }
    } catch (err) {
        console.error(`Error: ${err.message}`);
    }
}

incrementVersion();
