<script setup="ts">
import PlayersContainer from './components/PlayersContainer.vue';
import Error from './components/Error.vue';
import { ref, onMounted } from 'vue';
import Scoreboard from './components/Scoreboard.vue';

const redScore = ref(0);
const blueScore = ref(0);
const timer = ref(0);
const players = ref([]);
const showError = ref(false);

function handleWebSocketData(data) {
  try {
    const parsedData = JSON.parse(data);
    if (parsedData && Array.isArray(parsedData.players)) {
      redScore.value = 0;
      blueScore.value = 0;
      players.value = parsedData.players;
      timer.value = parsedData.timelimit - parsedData.effectiveTime;

      parsedData.players.forEach(player => {
        if (player.team === 'red') {
          redScore.value += player.frags;
        } else if (player.team === 'blue') {
          blueScore.value += player.frags;
        }
      });
    } else {
      showError.value = true;
    }
  } catch (error) {
    showError.value = true;
  }
}

onMounted(() => {
  const socket = new WebSocket('ws://127.0.0.1:8080');

  socket.addEventListener('message', (event) => {
    handleWebSocketData(event.data);
  });
});
</script>

<template>
  <div id="main">
    <Scoreboard :redScore="redScore" :blueScore="blueScore" :timer='timer'/>
    <PlayersContainer :players="players" />
    <Error v-if="showError" />
  </div>
</template>

<style scoped>
#main {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  overflow: hidden;
  width: 1920px;
  height: 1080px;
  background-color: rgba(0,0,0,0.0);
}
</style>
