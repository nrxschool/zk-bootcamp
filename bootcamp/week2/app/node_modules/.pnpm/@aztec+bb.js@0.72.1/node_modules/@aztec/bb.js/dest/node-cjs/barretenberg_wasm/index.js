"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BarretenbergWasm = exports.fetchModuleAndThreads = void 0;
const tslib_1 = require("tslib");
const comlink_1 = require("comlink");
const debug_1 = tslib_1.__importDefault(require("debug"));
const index_js_1 = require("./barretenberg_wasm_main/factory/node/index.js");
const index_js_2 = require("./helpers/node/index.js");
const index_js_3 = require("./barretenberg_wasm_main/index.js");
const index_js_4 = require("./fetch_code/index.js");
const debug = (0, debug_1.default)('bb.js:wasm');
async function fetchModuleAndThreads(desiredThreads = 32) {
    const shared = (0, index_js_2.getSharedMemoryAvailable)();
    const availableThreads = shared ? await getAvailableThreads() : 1;
    // We limit the number of threads to 32 as we do not benefit from greater numbers.
    const limitedThreads = Math.min(desiredThreads, availableThreads, 32);
    const code = await (0, index_js_4.fetchCode)(shared);
    const module = await WebAssembly.compile(code);
    return { module, threads: limitedThreads };
}
exports.fetchModuleAndThreads = fetchModuleAndThreads;
async function getAvailableThreads() {
    if (typeof navigator !== 'undefined' && navigator.hardwareConcurrency) {
        return navigator.hardwareConcurrency;
    }
    else {
        try {
            const os = await Promise.resolve().then(() => tslib_1.__importStar(require('os')));
            return os.cpus().length;
        }
        catch (e) {
            debug(`Could not detect environment. Falling back to one thread.: {e}`);
            return 1;
        }
    }
}
class BarretenbergWasm extends index_js_3.BarretenbergWasmMain {
    /**
     * Construct and initialize BarretenbergWasm within a Worker. Return both the worker and the wasm proxy.
     * Used when running in the browser, because we can't block the main thread.
     */
    static async new(desiredThreads) {
        const worker = (0, index_js_1.createMainWorker)();
        const wasm = (0, index_js_2.getRemoteBarretenbergWasm)(worker);
        const { module, threads } = await fetchModuleAndThreads(desiredThreads);
        await wasm.init(module, threads, (0, comlink_1.proxy)(debug));
        return { worker, wasm };
    }
}
exports.BarretenbergWasm = BarretenbergWasm;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi9zcmMvYmFycmV0ZW5iZXJnX3dhc20vaW5kZXgudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7OztBQUFBLHFDQUFnQztBQUNoQywwREFBZ0M7QUFDaEMsNkVBQWtGO0FBQ2xGLHNEQUE4RjtBQUM5RixnRUFBcUc7QUFDckcsb0RBQWtEO0FBRWxELE1BQU0sS0FBSyxHQUFHLElBQUEsZUFBVyxFQUFDLFlBQVksQ0FBQyxDQUFDO0FBRWpDLEtBQUssVUFBVSxxQkFBcUIsQ0FBQyxjQUFjLEdBQUcsRUFBRTtJQUM3RCxNQUFNLE1BQU0sR0FBRyxJQUFBLG1DQUF3QixHQUFFLENBQUM7SUFFMUMsTUFBTSxnQkFBZ0IsR0FBRyxNQUFNLENBQUMsQ0FBQyxDQUFDLE1BQU0sbUJBQW1CLEVBQUUsQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDO0lBQ2xFLGtGQUFrRjtJQUNsRixNQUFNLGNBQWMsR0FBRyxJQUFJLENBQUMsR0FBRyxDQUFDLGNBQWMsRUFBRSxnQkFBZ0IsRUFBRSxFQUFFLENBQUMsQ0FBQztJQUV0RSxNQUFNLElBQUksR0FBRyxNQUFNLElBQUEsb0JBQVMsRUFBQyxNQUFNLENBQUMsQ0FBQztJQUNyQyxNQUFNLE1BQU0sR0FBRyxNQUFNLFdBQVcsQ0FBQyxPQUFPLENBQUMsSUFBSSxDQUFDLENBQUM7SUFDL0MsT0FBTyxFQUFFLE1BQU0sRUFBRSxPQUFPLEVBQUUsY0FBYyxFQUFFLENBQUM7QUFDN0MsQ0FBQztBQVZELHNEQVVDO0FBRUQsS0FBSyxVQUFVLG1CQUFtQjtJQUNoQyxJQUFJLE9BQU8sU0FBUyxLQUFLLFdBQVcsSUFBSSxTQUFTLENBQUMsbUJBQW1CLEVBQUUsQ0FBQztRQUN0RSxPQUFPLFNBQVMsQ0FBQyxtQkFBbUIsQ0FBQztJQUN2QyxDQUFDO1NBQU0sQ0FBQztRQUNOLElBQUksQ0FBQztZQUNILE1BQU0sRUFBRSxHQUFHLGdFQUFhLElBQUksR0FBQyxDQUFDO1lBQzlCLE9BQU8sRUFBRSxDQUFDLElBQUksRUFBRSxDQUFDLE1BQU0sQ0FBQztRQUMxQixDQUFDO1FBQUMsT0FBTyxDQUFDLEVBQUUsQ0FBQztZQUNYLEtBQUssQ0FBQyxnRUFBZ0UsQ0FBQyxDQUFDO1lBQ3hFLE9BQU8sQ0FBQyxDQUFDO1FBQ1gsQ0FBQztJQUNILENBQUM7QUFDSCxDQUFDO0FBRUQsTUFBYSxnQkFBaUIsU0FBUSwrQkFBb0I7SUFDeEQ7OztPQUdHO0lBQ0ksTUFBTSxDQUFDLEtBQUssQ0FBQyxHQUFHLENBQUMsY0FBdUI7UUFDN0MsTUFBTSxNQUFNLEdBQUcsSUFBQSwyQkFBZ0IsR0FBRSxDQUFDO1FBQ2xDLE1BQU0sSUFBSSxHQUFHLElBQUEsb0NBQXlCLEVBQTZCLE1BQU0sQ0FBQyxDQUFDO1FBQzNFLE1BQU0sRUFBRSxNQUFNLEVBQUUsT0FBTyxFQUFFLEdBQUcsTUFBTSxxQkFBcUIsQ0FBQyxjQUFjLENBQUMsQ0FBQztRQUN4RSxNQUFNLElBQUksQ0FBQyxJQUFJLENBQUMsTUFBTSxFQUFFLE9BQU8sRUFBRSxJQUFBLGVBQUssRUFBQyxLQUFLLENBQUMsQ0FBQyxDQUFDO1FBQy9DLE9BQU8sRUFBRSxNQUFNLEVBQUUsSUFBSSxFQUFFLENBQUM7SUFDMUIsQ0FBQztDQUNGO0FBWkQsNENBWUMifQ==