<script setup lang="ts">
import { ref, onMounted } from 'vue';
import PlayersContainer from './components/PlayersContainer.vue';
import Error from './components/Error.vue';
import Settings from './components/Settings.vue';
import Scoreboard from './components/Scoreboard.vue';
import { Player } from './models/Player';

const leftTeamScore = ref(0);
const rightTeamScore = ref(0);
const timer = ref(0);
const players = ref([]);
const showError = ref(false);
const leftTeamModel = ref('red');
const rightTeamModel = ref('blue');

function handleWebSocketData(data: string) {
  try {
    const parsedData = JSON.parse(data);
    if (parsedData && Array.isArray(parsedData.players)) {
      leftTeamScore.value = 0;
      rightTeamScore.value = 0;
      players.value = parsedData.players;
      timer.value = parsedData.timelimit - parsedData.effectiveTime;

      parsedData.players.forEach((player: Player) => {
        if (player.team === leftTeamModel.value) {
          leftTeamScore.value += player.frags;
        } else if (player.team === rightTeamModel.value) {
          rightTeamScore.value += player.frags;
        }
      });
    } else {
      showError.value = true;
    }
  } catch (error) {
    showError.value = true;
  }
}

function updateTeamModel(team: string, model: string): void {
  if (team === 'left') {
    leftTeamModel.value = model;
  } else if (team === 'right') {
    rightTeamModel.value = model;
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
    <Scoreboard :redScore="leftTeamScore" :blueScore="rightTeamScore" :timer='timer'/>
    <PlayersContainer :players="players" :leftTeamModel="leftTeamModel" :rightTeamModel="rightTeamModel"/>
    <Error v-if="showError" />
    <Settings
      :leftTeamModel="leftTeamModel"
      :rightTeamModel="rightTeamModel"
      :updateTeamModel="updateTeamModel"
    />
  </div>
</template>

<style scoped>
#main {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  overflow: visible;
  width: 1920px;
  height: 1080px;
  background-color: rgba(0, 0, 0, 0.0);
  position: relative;
}

#team-model-settings {
  position: absolute;
  top: 1080px;
  width: 100%;
  background-color: #333;
  color: #fff;
  padding: 20px;
  display: flex;
  justify-content: space-around;
  align-items: center;
}

.team-model {
  display: flex;
  flex-direction: column;
}

label {
  font-weight: bold;
  margin-bottom: 5px;
}

input {
  padding: 5px;
  border-radius: 5px;
  border: 1px solid #ccc;
}
</style>