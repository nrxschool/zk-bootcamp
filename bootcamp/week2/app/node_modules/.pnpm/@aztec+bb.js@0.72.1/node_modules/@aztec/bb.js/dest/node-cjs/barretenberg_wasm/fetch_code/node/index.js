"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.fetchCode = void 0;
const tslib_1 = require("tslib");
const promises_1 = require("fs/promises");
const path_1 = require("path");
const url_1 = require("url");
const pako_1 = tslib_1.__importDefault(require("pako"));
function getCurrentDir() {
    if (typeof __dirname !== 'undefined') {
        return __dirname;
    }
    else {
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
        return (0, path_1.dirname)((0, url_1.fileURLToPath)(""));
    }
}
// eslint-disable-next-line @typescript-eslint/no-unused-vars
async function fetchCode(multithreaded) {
    const path = getCurrentDir() + '/../../barretenberg-threads.wasm.gz';
    const compressedData = await (0, promises_1.readFile)(path);
    const decompressedData = pako_1.default.ungzip(new Uint8Array(compressedData));
    return decompressedData.buffer;
}
exports.fetchCode = fetchCode;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9zcmMvYmFycmV0ZW5iZXJnX3dhc20vZmV0Y2hfY29kZS9ub2RlL2luZGV4LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7Ozs7QUFBQSwwQ0FBdUM7QUFDdkMsK0JBQStCO0FBQy9CLDZCQUFvQztBQUNwQyx3REFBd0I7QUFFeEIsU0FBUyxhQUFhO0lBQ3BCLElBQUksT0FBTyxTQUFTLEtBQUssV0FBVyxFQUFFLENBQUM7UUFDckMsT0FBTyxTQUFTLENBQUM7SUFDbkIsQ0FBQztTQUFNLENBQUM7UUFDTiw2REFBNkQ7UUFDN0QsYUFBYTtRQUNiLE9BQU8sSUFBQSxjQUFPLEVBQUMsSUFBQSxtQkFBYSxFQUFDLE1BQU0sQ0FBQyxJQUFJLENBQUMsR0FBRyxDQUFDLENBQUMsQ0FBQztJQUNqRCxDQUFDO0FBQ0gsQ0FBQztBQUVELDZEQUE2RDtBQUN0RCxLQUFLLFVBQVUsU0FBUyxDQUFDLGFBQXNCO0lBQ3BELE1BQU0sSUFBSSxHQUFHLGFBQWEsRUFBRSxHQUFHLHFDQUFxQyxDQUFDO0lBQ3JFLE1BQU0sY0FBYyxHQUFHLE1BQU0sSUFBQSxtQkFBUSxFQUFDLElBQUksQ0FBQyxDQUFDO0lBQzVDLE1BQU0sZ0JBQWdCLEdBQUcsY0FBSSxDQUFDLE1BQU0sQ0FBQyxJQUFJLFVBQVUsQ0FBQyxjQUFjLENBQUMsQ0FBQyxDQUFDO0lBQ3JFLE9BQU8sZ0JBQWdCLENBQUMsTUFBTSxDQUFDO0FBQ2pDLENBQUM7QUFMRCw4QkFLQyJ9