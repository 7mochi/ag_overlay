<script setup lang="ts">
import { Player as PlayerModel } from '../models/Player';
import Player from './Player.vue';
import { computed } from 'vue';

const props = defineProps<{
  players: Array<PlayerModel>;
  leftTeamModel: string;
  rightTeamModel: string;
}>();

const leftTeamPlayers = computed(() => props.players.filter(player => player.team === props.leftTeamModel));
const redTeamPlayers = computed(() => props.players.filter(player => player.team === props.rightTeamModel));
</script>

<template>
  <div id="playersContainer">
    <Player :players="leftTeamPlayers" :isLeft=true teamClass="team-red" />
    <Player :players="redTeamPlayers" :isLeft=false teamClass="team-blue" />
  </div>
</template>

<style scoped>
#playersContainer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100%;
  width: 100%;
  box-sizing: border-box;
  padding: 0 20px;
}
</style>
