import { Player } from "./Player";

export interface Data {
  players: Array<Player>;
  timelimit: Number;
  effectiveTime: Number;
}
