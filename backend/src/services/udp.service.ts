import { createSocket } from 'dgram';
import fastify from '../app';
import { WebSocket } from 'ws';

export function startUDPServer() {
    const udpServer = createSocket('udp4');

    udpServer.on('message', (msg, rinfo) => {
        const jsonData = msg.toString();
        console.log(`Data received from AMXX plugin at ${rinfo.address}:${rinfo.port}:`, jsonData);

        fastify.websocketServer.clients.forEach((client: WebSocket) => {
            if (client.readyState === WebSocket.OPEN) {
                client.send(jsonData);
            }
        });
    });

    udpServer.on('error', (err) => {
        console.log("Error in UDP server:", err);
        udpServer.close();
    });

    udpServer.bind(3000, () => {
        console.log("UDP server listening on port 3000.");
    });
}
