"use client";

import "./globals.css";
import { TonConnectUIProvider } from "@tonconnect/ui-react";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  console.log("ICON_IPFS", process.env.ICON_IPFS);

  const manifestIPFS = "https://yellow-accused-earwig-831.mypinata.cloud/ipfs/bafkreif37arloqkzd76trz7edg534v26vqmd4ykxuwibgdelwr3m3xvbty"
  return (
    <html lang="en">
      <head>
        <title>TON Connect Demo</title>
      </head>
      <body>
        <TonConnectUIProvider manifestUrl={manifestIPFS}>>
          {children}
        </TonConnectUIProvider>
      </body>
    </html>
  );
}
