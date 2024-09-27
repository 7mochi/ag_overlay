<script setup lang="ts">
defineProps<{
  redScore: number;
  blueScore: number;
  timer: number;
}>();

function formatTime(time: number): string {
  const minutes = Math.floor(time / 60);
  const seconds = time % 60;
  return `${minutes}:${seconds < 10 ? `0${seconds}` : seconds}`;
}
</script>

<template>
  <div id="scores">
    <div id="scoreContainer">
      <div id="scoresWrapper">
        <img :src="`src/assets/team/red.png`" id="team-image"/>
        <div id="scoreText">
          {{ redScore }}
        </div>
        <div id="scoreText">
          {{ blueScore }}
        </div>
        <img :src="`src/assets/team/blue.png`" id="team-image"/>
      </div>
      <div id="timerContainer">
        <div id="timerText">
          {{ formatTime(timer) }}
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
#scoreContainer {
  color: #ffffff;
  position: absolute;
  top: 20px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(50, 50, 50, 0.8);
  padding: 15px 30px;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
}

#scoresWrapper {
  display: flex;
  align-items: center;
}

#scoreText {
  font-size: 32px;
  font-weight: bold;
  color: #ffffff;
  padding: 30px;
}

#team-image {
  height: 100px;
}

#timerContainer {
  display: flex;
  justify-content: center;
  width: 100%;
  margin-top: auto;
}

#timerText {
  /* Estilos para el texto del temporizador */
}

</style>
