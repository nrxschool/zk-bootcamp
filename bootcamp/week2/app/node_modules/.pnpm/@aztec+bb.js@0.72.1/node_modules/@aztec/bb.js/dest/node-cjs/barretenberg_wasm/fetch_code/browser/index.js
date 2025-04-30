"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.fetchCode = void 0;
const tslib_1 = require("tslib");
const barretenberg_wasm_gz_1 = tslib_1.__importDefault(require("../../barretenberg.wasm.gz"));
const barretenberg_threads_wasm_gz_1 = tslib_1.__importDefault(require("../../barretenberg-threads.wasm.gz"));
const pako_1 = tslib_1.__importDefault(require("pako"));
// Annoyingly the wasm declares if it's memory is shared or not. So now we need two wasms if we want to be
// able to fallback on "non shared memory" situations.
async function fetchCode(multithreaded) {
    const res = await fetch(multithreaded ? barretenberg_threads_wasm_gz_1.default : barretenberg_wasm_gz_1.default);
    const compressedData = await res.arrayBuffer();
    const decompressedData = pako_1.default.ungzip(new Uint8Array(compressedData));
    return decompressedData.buffer;
}
exports.fetchCode = fetchCode;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9zcmMvYmFycmV0ZW5iZXJnX3dhc20vZmV0Y2hfY29kZS9icm93c2VyL2luZGV4LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7Ozs7QUFBQSw4RkFBNEQ7QUFDNUQsOEdBQTJFO0FBQzNFLHdEQUF3QjtBQUV4QiwwR0FBMEc7QUFDMUcsc0RBQXNEO0FBQy9DLEtBQUssVUFBVSxTQUFTLENBQUMsYUFBc0I7SUFDcEQsTUFBTSxHQUFHLEdBQUcsTUFBTSxLQUFLLENBQUMsYUFBYSxDQUFDLENBQUMsQ0FBQyxzQ0FBeUIsQ0FBQyxDQUFDLENBQUMsOEJBQWtCLENBQUMsQ0FBQztJQUN4RixNQUFNLGNBQWMsR0FBRyxNQUFNLEdBQUcsQ0FBQyxXQUFXLEVBQUUsQ0FBQztJQUMvQyxNQUFNLGdCQUFnQixHQUFHLGNBQUksQ0FBQyxNQUFNLENBQUMsSUFBSSxVQUFVLENBQUMsY0FBYyxDQUFDLENBQUMsQ0FBQztJQUNyRSxPQUFPLGdCQUFnQixDQUFDLE1BQU0sQ0FBQztBQUNqQyxDQUFDO0FBTEQsOEJBS0MifQ==