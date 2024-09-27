import fastify from './app';
import { startUDPServer } from './services/udp.service';

fastify.listen({ host: "0.0.0.0", port: 8080 }, (err, address) => {
    if (err) {
        console.log("Error initializing Fastify server:", err);

        process.exit(1);
    }
    console.log(`Fastify server listening on ${address}`);
});

startUDPServer();
