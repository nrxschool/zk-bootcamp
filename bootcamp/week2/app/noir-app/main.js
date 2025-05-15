const { zkVerifySession, ZkVerifyEvents } = require("zkverifyjs");
const fs = require("fs");

async function main() {
  console.log("Starting main function...");
  
  console.log("Reading proof and public files...");
  const proof = fs.readFileSync("./out/hex/proof.hex").toString();
  const public = fs.readFileSync("./out/hex/pub.hex").toString();

  const SEED = "jacket worry seven predict jaguar next tissue pond panda bronze oil chair";



  console.log("Initializing zkVerify session...");
  const session = await zkVerifySession.start().Volta().withAccount(SEED);
  console.log("Session initialized successfully");

  console.log("Reading verification key file...");
  let vk = fs.readFileSync("./out/hex/vk.hex").toString();

//   console.log("Registering verification key...");
//   const { events: events1, regResult } = await session
//     .registerVerificationKey()
//     .ultraplonk()
//     .execute(vk.split("\n")[0]);
//   console.log("Verification key registered");

//   events1.on(ZkVerifyEvents.Finalized, (eventData) => {
//     console.log("Verification finalized:", eventData);
//     console.log("Writing verification key hash to vkey.json...");
//     fs.writeFileSync(
//       "vkey.json",
//       JSON.stringify({ hash: eventData.statementHash }, null, 2)
//     );
//     console.log("Hash written successfully");
//     return eventData.statementHash;
//   });

  /////////////
//   console.log("Loading verification key hash from vkey.json...");
//   const vkey = require("./vkey.json");
//   console.log("Verification key hash loaded");

  console.log("Setting up event subscription...");
  session.subscribe([
    {
      event: ZkVerifyEvents.NewAggregationReceipt,
      callback: async (eventData) => {
        console.log("New aggregation receipt received:", eventData);
        console.log("Getting aggregate statement path...");
        let statementpath = await session.getAggregateStatementPath(
          eventData.blockHash,
          parseInt(eventData.data.domainId),
          parseInt(eventData.data.aggregationId),
          statement
        );
        console.log("Statement path retrieved:", statementpath);
        const statementproof = {
          ...statementpath,
          domainId: parseInt(eventData.data.domainId),
          aggregationId: parseInt(eventData.data.aggregationId),
        };
        console.log("Writing statement proof to aggregation.json...");
        fs.writeFile("aggregation.json", JSON.stringify(statementproof));
        console.log("Statement proof written successfully");
      },
      options: { domainId: 0 },
    },
  ]);
  console.log("Event subscription set up successfully");

  console.log("Executing verification...");
  const { events: events2 } = await session
    .verify()
    .ultraplonk()
    // .withRegisteredVk()
    .execute({
      proofData: {
        proof: proof.split("\n")[0],
        // vk: vkey.hash,
        vk: vk.split("\n")[0],
        publicSignals: public.split("\n").slice(0, -1),
      },
      domainId: 0,
    });
  console.log("Verification executed");

  events2.on(ZkVerifyEvents.IncludedInBlock, (eventData) => {
    console.log("Proof included in block:", eventData);
    statement = eventData.statement;
    console.log("Statement updated:", statement);
  });



  session.getAggregateStatementPath()
}

console.log("Starting program...");
main().catch(error => {
  console.error("Error in main function:", error);
});
