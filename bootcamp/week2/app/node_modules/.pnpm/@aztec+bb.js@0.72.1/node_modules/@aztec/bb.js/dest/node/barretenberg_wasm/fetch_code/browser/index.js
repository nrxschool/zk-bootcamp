import barretenbergModule from '../../barretenberg.wasm.gz';
import barretenbergThreadsModule from '../../barretenberg-threads.wasm.gz';
import pako from 'pako';
// Annoyingly the wasm declares if it's memory is shared or not. So now we need two wasms if we want to be
// able to fallback on "non shared memory" situations.
export async function fetchCode(multithreaded) {
    const res = await fetch(multithreaded ? barretenbergThreadsModule : barretenbergModule);
    const compressedData = await res.arrayBuffer();
    const decompressedData = pako.ungzip(new Uint8Array(compressedData));
    return decompressedData.buffer;
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9zcmMvYmFycmV0ZW5iZXJnX3dhc20vZmV0Y2hfY29kZS9icm93c2VyL2luZGV4LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBLE9BQU8sa0JBQWtCLE1BQU0sNEJBQTRCLENBQUM7QUFDNUQsT0FBTyx5QkFBeUIsTUFBTSxvQ0FBb0MsQ0FBQztBQUMzRSxPQUFPLElBQUksTUFBTSxNQUFNLENBQUM7QUFFeEIsMEdBQTBHO0FBQzFHLHNEQUFzRDtBQUN0RCxNQUFNLENBQUMsS0FBSyxVQUFVLFNBQVMsQ0FBQyxhQUFzQjtJQUNwRCxNQUFNLEdBQUcsR0FBRyxNQUFNLEtBQUssQ0FBQyxhQUFhLENBQUMsQ0FBQyxDQUFDLHlCQUF5QixDQUFDLENBQUMsQ0FBQyxrQkFBa0IsQ0FBQyxDQUFDO0lBQ3hGLE1BQU0sY0FBYyxHQUFHLE1BQU0sR0FBRyxDQUFDLFdBQVcsRUFBRSxDQUFDO0lBQy9DLE1BQU0sZ0JBQWdCLEdBQUcsSUFBSSxDQUFDLE1BQU0sQ0FBQyxJQUFJLFVBQVUsQ0FBQyxjQUFjLENBQUMsQ0FBQyxDQUFDO0lBQ3JFLE9BQU8sZ0JBQWdCLENBQUMsTUFBTSxDQUFDO0FBQ2pDLENBQUMifQ==