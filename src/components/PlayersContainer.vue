<script setup lang="ts">
import { Player as PlayerModel } from '../models/Player';
import Player from './Player.vue';
import { computed } from 'vue';

const props = defineProps<{
  players: Array<PlayerModel>;
}>();

const redPlayers = computed(() => props.players.filter(player => player.team === 'red'));
const bluePlayers = computed(() => props.players.filter(player => player.team === 'blue'));
</script>

<template>
  <div id="playersContainer">
    <Player :players="redPlayers" teamClass="team-red" />
    <Player :players="bluePlayers" teamClass="team-blue" />
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
