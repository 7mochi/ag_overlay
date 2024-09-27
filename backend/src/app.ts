import Fastify from 'fastify';
import fastifyWebSocket from '@fastify/websocket';
import websocketController from './controllers/websocket.controller';

const fastify = Fastify();

fastify.register(fastifyWebSocket);
fastify.register(websocketController);

export default fastify;
