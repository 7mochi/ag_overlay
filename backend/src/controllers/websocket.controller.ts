import { FastifyInstance } from "fastify";
import { WebSocket } from "ws";

async function websocketController(fastify: FastifyInstance) {
  fastify.get("/", { websocket: true }, (socket, req) => {
    console.log("WebSocket client connected.");

    socket.on("close", (code: number, reason: Buffer) => {
      const reasonString = reason ? reason.toString() : "No reason";
      console.log(
        "WebSocket client disconnected. Código:",
        code,
        "Reason:",
        reasonString
      );
    });

    socket.on("error", (err: Error) => {
      console.error("WebSocket error:", err);
    });
  });
}

export default websocketController;
