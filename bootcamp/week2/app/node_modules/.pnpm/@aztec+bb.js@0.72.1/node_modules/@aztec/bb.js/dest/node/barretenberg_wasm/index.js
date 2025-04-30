import { proxy } from 'comlink';
import createDebug from 'debug';
import { createMainWorker } from './barretenberg_wasm_main/factory/node/index.js';
import { getRemoteBarretenbergWasm, getSharedMemoryAvailable } from './helpers/node/index.js';
import { BarretenbergWasmMain } from './barretenberg_wasm_main/index.js';
import { fetchCode } from './fetch_code/index.js';
const debug = createDebug('bb.js:wasm');
export async function fetchModuleAndThreads(desiredThreads = 32) {
    const shared = getSharedMemoryAvailable();
    const availableThreads = shared ? await getAvailableThreads() : 1;
    // We limit the number of threads to 32 as we do not benefit from greater numbers.
    const limitedThreads = Math.min(desiredThreads, availableThreads, 32);
    const code = await fetchCode(shared);
    const module = await WebAssembly.compile(code);
    return { module, threads: limitedThreads };
}
async function getAvailableThreads() {
    if (typeof navigator !== 'undefined' && navigator.hardwareConcurrency) {
        return navigator.hardwareConcurrency;
    }
    else {
        try {
            const os = await import('os');
            return os.cpus().length;
        }
        catch (e) {
            debug(`Could not detect environment. Falling back to one thread.: {e}`);
            return 1;
        }
    }
}
export class BarretenbergWasm extends BarretenbergWasmMain {
    /**
     * Construct and initialize BarretenbergWasm within a Worker. Return both the worker and the wasm proxy.
     * Used when running in the browser, because we can't block the main thread.
     */
    static async new(desiredThreads) {
        const worker = createMainWorker();
        const wasm = getRemoteBarretenbergWasm(worker);
        const { module, threads } = await fetchModuleAndThreads(desiredThreads);
        await wasm.init(module, threads, proxy(debug));
        return { worker, wasm };
    }
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi9zcmMvYmFycmV0ZW5iZXJnX3dhc20vaW5kZXgudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsT0FBTyxFQUFFLEtBQUssRUFBRSxNQUFNLFNBQVMsQ0FBQztBQUNoQyxPQUFPLFdBQVcsTUFBTSxPQUFPLENBQUM7QUFDaEMsT0FBTyxFQUFFLGdCQUFnQixFQUFFLE1BQU0sZ0RBQWdELENBQUM7QUFDbEYsT0FBTyxFQUFFLHlCQUF5QixFQUFFLHdCQUF3QixFQUFFLE1BQU0seUJBQXlCLENBQUM7QUFDOUYsT0FBTyxFQUFFLG9CQUFvQixFQUE4QixNQUFNLG1DQUFtQyxDQUFDO0FBQ3JHLE9BQU8sRUFBRSxTQUFTLEVBQUUsTUFBTSx1QkFBdUIsQ0FBQztBQUVsRCxNQUFNLEtBQUssR0FBRyxXQUFXLENBQUMsWUFBWSxDQUFDLENBQUM7QUFFeEMsTUFBTSxDQUFDLEtBQUssVUFBVSxxQkFBcUIsQ0FBQyxjQUFjLEdBQUcsRUFBRTtJQUM3RCxNQUFNLE1BQU0sR0FBRyx3QkFBd0IsRUFBRSxDQUFDO0lBRTFDLE1BQU0sZ0JBQWdCLEdBQUcsTUFBTSxDQUFDLENBQUMsQ0FBQyxNQUFNLG1CQUFtQixFQUFFLENBQUMsQ0FBQyxDQUFDLENBQUMsQ0FBQztJQUNsRSxrRkFBa0Y7SUFDbEYsTUFBTSxjQUFjLEdBQUcsSUFBSSxDQUFDLEdBQUcsQ0FBQyxjQUFjLEVBQUUsZ0JBQWdCLEVBQUUsRUFBRSxDQUFDLENBQUM7SUFFdEUsTUFBTSxJQUFJLEdBQUcsTUFBTSxTQUFTLENBQUMsTUFBTSxDQUFDLENBQUM7SUFDckMsTUFBTSxNQUFNLEdBQUcsTUFBTSxXQUFXLENBQUMsT0FBTyxDQUFDLElBQUksQ0FBQyxDQUFDO0lBQy9DLE9BQU8sRUFBRSxNQUFNLEVBQUUsT0FBTyxFQUFFLGNBQWMsRUFBRSxDQUFDO0FBQzdDLENBQUM7QUFFRCxLQUFLLFVBQVUsbUJBQW1CO0lBQ2hDLElBQUksT0FBTyxTQUFTLEtBQUssV0FBVyxJQUFJLFNBQVMsQ0FBQyxtQkFBbUIsRUFBRSxDQUFDO1FBQ3RFLE9BQU8sU0FBUyxDQUFDLG1CQUFtQixDQUFDO0lBQ3ZDLENBQUM7U0FBTSxDQUFDO1FBQ04sSUFBSSxDQUFDO1lBQ0gsTUFBTSxFQUFFLEdBQUcsTUFBTSxNQUFNLENBQUMsSUFBSSxDQUFDLENBQUM7WUFDOUIsT0FBTyxFQUFFLENBQUMsSUFBSSxFQUFFLENBQUMsTUFBTSxDQUFDO1FBQzFCLENBQUM7UUFBQyxPQUFPLENBQUMsRUFBRSxDQUFDO1lBQ1gsS0FBSyxDQUFDLGdFQUFnRSxDQUFDLENBQUM7WUFDeEUsT0FBTyxDQUFDLENBQUM7UUFDWCxDQUFDO0lBQ0gsQ0FBQztBQUNILENBQUM7QUFFRCxNQUFNLE9BQU8sZ0JBQWlCLFNBQVEsb0JBQW9CO0lBQ3hEOzs7T0FHRztJQUNJLE1BQU0sQ0FBQyxLQUFLLENBQUMsR0FBRyxDQUFDLGNBQXVCO1FBQzdDLE1BQU0sTUFBTSxHQUFHLGdCQUFnQixFQUFFLENBQUM7UUFDbEMsTUFBTSxJQUFJLEdBQUcseUJBQXlCLENBQTZCLE1BQU0sQ0FBQyxDQUFDO1FBQzNFLE1BQU0sRUFBRSxNQUFNLEVBQUUsT0FBTyxFQUFFLEdBQUcsTUFBTSxxQkFBcUIsQ0FBQyxjQUFjLENBQUMsQ0FBQztRQUN4RSxNQUFNLElBQUksQ0FBQyxJQUFJLENBQUMsTUFBTSxFQUFFLE9BQU8sRUFBRSxLQUFLLENBQUMsS0FBSyxDQUFDLENBQUMsQ0FBQztRQUMvQyxPQUFPLEVBQUUsTUFBTSxFQUFFLElBQUksRUFBRSxDQUFDO0lBQzFCLENBQUM7Q0FDRiJ9