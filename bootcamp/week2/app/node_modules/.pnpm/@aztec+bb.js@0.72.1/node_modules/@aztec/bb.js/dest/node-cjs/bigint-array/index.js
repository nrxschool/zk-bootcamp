"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.toBufferBE = exports.toBigIntBE = void 0;
function toBigIntBE(bytes) {
    // A Buffer in node, *is* a Uint8Array. We can't refuse it's type.
    // However the algo below only works on an actual Uint8Array, hence we make a new one to be safe.
    bytes = new Uint8Array(bytes);
    let bigint = BigInt(0);
    const view = new DataView(bytes.buffer);
    for (let i = 0; i < bytes.byteLength; i++) {
        bigint = (bigint << BigInt(8)) + BigInt(view.getUint8(i));
    }
    return bigint;
}
exports.toBigIntBE = toBigIntBE;
function toBufferBE(value, byteLength = 32) {
    const bytes = new Uint8Array(byteLength);
    const view = new DataView(bytes.buffer);
    for (let i = 0; i < byteLength; i++) {
        view.setUint8(byteLength - i - 1, Number(value & BigInt(0xff)));
        value >>= BigInt(8);
    }
    return bytes;
}
exports.toBufferBE = toBufferBE;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi9zcmMvYmlnaW50LWFycmF5L2luZGV4LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7OztBQUFBLFNBQWdCLFVBQVUsQ0FBQyxLQUFpQjtJQUMxQyxrRUFBa0U7SUFDbEUsaUdBQWlHO0lBQ2pHLEtBQUssR0FBRyxJQUFJLFVBQVUsQ0FBQyxLQUFLLENBQUMsQ0FBQztJQUM5QixJQUFJLE1BQU0sR0FBRyxNQUFNLENBQUMsQ0FBQyxDQUFDLENBQUM7SUFDdkIsTUFBTSxJQUFJLEdBQUcsSUFBSSxRQUFRLENBQUMsS0FBSyxDQUFDLE1BQU0sQ0FBQyxDQUFDO0lBQ3hDLEtBQUssSUFBSSxDQUFDLEdBQUcsQ0FBQyxFQUFFLENBQUMsR0FBRyxLQUFLLENBQUMsVUFBVSxFQUFFLENBQUMsRUFBRSxFQUFFLENBQUM7UUFDMUMsTUFBTSxHQUFHLENBQUMsTUFBTSxJQUFJLE1BQU0sQ0FBQyxDQUFDLENBQUMsQ0FBQyxHQUFHLE1BQU0sQ0FBQyxJQUFJLENBQUMsUUFBUSxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUM7SUFDNUQsQ0FBQztJQUNELE9BQU8sTUFBTSxDQUFDO0FBQ2hCLENBQUM7QUFWRCxnQ0FVQztBQUVELFNBQWdCLFVBQVUsQ0FBQyxLQUFhLEVBQUUsVUFBVSxHQUFHLEVBQUU7SUFDdkQsTUFBTSxLQUFLLEdBQUcsSUFBSSxVQUFVLENBQUMsVUFBVSxDQUFDLENBQUM7SUFDekMsTUFBTSxJQUFJLEdBQUcsSUFBSSxRQUFRLENBQUMsS0FBSyxDQUFDLE1BQU0sQ0FBQyxDQUFDO0lBQ3hDLEtBQUssSUFBSSxDQUFDLEdBQUcsQ0FBQyxFQUFFLENBQUMsR0FBRyxVQUFVLEVBQUUsQ0FBQyxFQUFFLEVBQUUsQ0FBQztRQUNwQyxJQUFJLENBQUMsUUFBUSxDQUFDLFVBQVUsR0FBRyxDQUFDLEdBQUcsQ0FBQyxFQUFFLE1BQU0sQ0FBQyxLQUFLLEdBQUcsTUFBTSxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsQ0FBQztRQUNoRSxLQUFLLEtBQUssTUFBTSxDQUFDLENBQUMsQ0FBQyxDQUFDO0lBQ3RCLENBQUM7SUFDRCxPQUFPLEtBQUssQ0FBQztBQUNmLENBQUM7QUFSRCxnQ0FRQyJ9