"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NetGrumpkinCrs = exports.NetCrs = void 0;
/**
 * Downloader for CRS from the web or local.
 */
class NetCrs {
    constructor(
    /**
     * The number of circuit gates.
     */
    numPoints) {
        this.numPoints = numPoints;
    }
    /**
     * Download the data.
     */
    async init() {
        await this.downloadG1Data();
        await this.downloadG2Data();
    }
    async downloadG1Data() {
        // Skip the download if numPoints is 0 (would download the entire file due to bad range header otherwise)
        if (this.numPoints === 0) {
            return (this.data = new Uint8Array([]));
        }
        const g1End = this.numPoints * 64 - 1;
        const response = await fetch('https://aztec-ignition.s3.amazonaws.com/MAIN%20IGNITION/flat/g1.dat', {
            headers: {
                Range: `bytes=0-${g1End}`,
            },
            cache: 'force-cache',
        });
        return (this.data = new Uint8Array(await response.arrayBuffer()));
    }
    /**
     * Download the G2 points data.
     */
    async downloadG2Data() {
        const response2 = await fetch('https://aztec-ignition.s3.amazonaws.com/MAIN%20IGNITION/flat/g2.dat', {
            cache: 'force-cache',
        });
        return (this.g2Data = new Uint8Array(await response2.arrayBuffer()));
    }
    /**
     * G1 points data for prover key.
     * @returns The points data.
     */
    getG1Data() {
        return this.data;
    }
    /**
     * G2 points data for verification key.
     * @returns The points data.
     */
    getG2Data() {
        return this.g2Data;
    }
}
exports.NetCrs = NetCrs;
/**
 * Downloader for CRS from the web or local.
 */
class NetGrumpkinCrs {
    constructor(
    /**
     * The number of circuit gates.
     */
    numPoints) {
        this.numPoints = numPoints;
    }
    /**
     * Download the data.
     */
    async init() {
        await this.downloadG1Data();
    }
    async downloadG1Data() {
        // Skip the download if numPoints is 0 (would download the entire file due to bad range header otherwise)
        if (this.numPoints === 0) {
            return (this.data = new Uint8Array([]));
        }
        const g1Start = 28;
        const g1End = this.numPoints * 64 - 1;
        const response = await fetch('https://aztec-ignition.s3.amazonaws.com/TEST%20GRUMPKIN/monomial/transcript00.dat', {
            headers: {
                Range: `bytes=${g1Start}-${g1End}`,
            },
            cache: 'force-cache',
        });
        return (this.data = new Uint8Array(await response.arrayBuffer()));
    }
    /**
     * G1 points data for prover key.
     * @returns The points data.
     */
    getG1Data() {
        return this.data;
    }
}
exports.NetGrumpkinCrs = NetGrumpkinCrs;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibmV0X2Nycy5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uL3NyYy9jcnMvbmV0X2Nycy50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7QUFBQTs7R0FFRztBQUNILE1BQWEsTUFBTTtJQUlqQjtJQUNFOztPQUVHO0lBQ2EsU0FBaUI7UUFBakIsY0FBUyxHQUFULFNBQVMsQ0FBUTtJQUNoQyxDQUFDO0lBRUo7O09BRUc7SUFDSCxLQUFLLENBQUMsSUFBSTtRQUNSLE1BQU0sSUFBSSxDQUFDLGNBQWMsRUFBRSxDQUFDO1FBQzVCLE1BQU0sSUFBSSxDQUFDLGNBQWMsRUFBRSxDQUFDO0lBQzlCLENBQUM7SUFFRCxLQUFLLENBQUMsY0FBYztRQUNsQix5R0FBeUc7UUFDekcsSUFBSSxJQUFJLENBQUMsU0FBUyxLQUFLLENBQUMsRUFBRSxDQUFDO1lBQ3pCLE9BQU8sQ0FBQyxJQUFJLENBQUMsSUFBSSxHQUFHLElBQUksVUFBVSxDQUFDLEVBQUUsQ0FBQyxDQUFDLENBQUM7UUFDMUMsQ0FBQztRQUVELE1BQU0sS0FBSyxHQUFHLElBQUksQ0FBQyxTQUFTLEdBQUcsRUFBRSxHQUFHLENBQUMsQ0FBQztRQUV0QyxNQUFNLFFBQVEsR0FBRyxNQUFNLEtBQUssQ0FBQyxxRUFBcUUsRUFBRTtZQUNsRyxPQUFPLEVBQUU7Z0JBQ1AsS0FBSyxFQUFFLFdBQVcsS0FBSyxFQUFFO2FBQzFCO1lBQ0QsS0FBSyxFQUFFLGFBQWE7U0FDckIsQ0FBQyxDQUFDO1FBRUgsT0FBTyxDQUFDLElBQUksQ0FBQyxJQUFJLEdBQUcsSUFBSSxVQUFVLENBQUMsTUFBTSxRQUFRLENBQUMsV0FBVyxFQUFFLENBQUMsQ0FBQyxDQUFDO0lBQ3BFLENBQUM7SUFFRDs7T0FFRztJQUNILEtBQUssQ0FBQyxjQUFjO1FBQ2xCLE1BQU0sU0FBUyxHQUFHLE1BQU0sS0FBSyxDQUFDLHFFQUFxRSxFQUFFO1lBQ25HLEtBQUssRUFBRSxhQUFhO1NBQ3JCLENBQUMsQ0FBQztRQUVILE9BQU8sQ0FBQyxJQUFJLENBQUMsTUFBTSxHQUFHLElBQUksVUFBVSxDQUFDLE1BQU0sU0FBUyxDQUFDLFdBQVcsRUFBRSxDQUFDLENBQUMsQ0FBQztJQUN2RSxDQUFDO0lBRUQ7OztPQUdHO0lBQ0gsU0FBUztRQUNQLE9BQU8sSUFBSSxDQUFDLElBQUksQ0FBQztJQUNuQixDQUFDO0lBRUQ7OztPQUdHO0lBQ0gsU0FBUztRQUNQLE9BQU8sSUFBSSxDQUFDLE1BQU0sQ0FBQztJQUNyQixDQUFDO0NBQ0Y7QUEvREQsd0JBK0RDO0FBRUQ7O0dBRUc7QUFDSCxNQUFhLGNBQWM7SUFHekI7SUFDRTs7T0FFRztJQUNhLFNBQWlCO1FBQWpCLGNBQVMsR0FBVCxTQUFTLENBQVE7SUFDaEMsQ0FBQztJQUVKOztPQUVHO0lBQ0gsS0FBSyxDQUFDLElBQUk7UUFDUixNQUFNLElBQUksQ0FBQyxjQUFjLEVBQUUsQ0FBQztJQUM5QixDQUFDO0lBRUQsS0FBSyxDQUFDLGNBQWM7UUFDbEIseUdBQXlHO1FBQ3pHLElBQUksSUFBSSxDQUFDLFNBQVMsS0FBSyxDQUFDLEVBQUUsQ0FBQztZQUN6QixPQUFPLENBQUMsSUFBSSxDQUFDLElBQUksR0FBRyxJQUFJLFVBQVUsQ0FBQyxFQUFFLENBQUMsQ0FBQyxDQUFDO1FBQzFDLENBQUM7UUFFRCxNQUFNLE9BQU8sR0FBRyxFQUFFLENBQUM7UUFDbkIsTUFBTSxLQUFLLEdBQUcsSUFBSSxDQUFDLFNBQVMsR0FBRyxFQUFFLEdBQUcsQ0FBQyxDQUFDO1FBRXRDLE1BQU0sUUFBUSxHQUFHLE1BQU0sS0FBSyxDQUFDLG1GQUFtRixFQUFFO1lBQ2hILE9BQU8sRUFBRTtnQkFDUCxLQUFLLEVBQUUsU0FBUyxPQUFPLElBQUksS0FBSyxFQUFFO2FBQ25DO1lBQ0QsS0FBSyxFQUFFLGFBQWE7U0FDckIsQ0FBQyxDQUFDO1FBRUgsT0FBTyxDQUFDLElBQUksQ0FBQyxJQUFJLEdBQUcsSUFBSSxVQUFVLENBQUMsTUFBTSxRQUFRLENBQUMsV0FBVyxFQUFFLENBQUMsQ0FBQyxDQUFDO0lBQ3BFLENBQUM7SUFFRDs7O09BR0c7SUFDSCxTQUFTO1FBQ1AsT0FBTyxJQUFJLENBQUMsSUFBSSxDQUFDO0lBQ25CLENBQUM7Q0FDRjtBQTNDRCx3Q0EyQ0MifQ==