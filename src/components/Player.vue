<script setup lang="ts">
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { library } from "@fortawesome/fontawesome-svg-core";
import { faHeart } from '@fortawesome/free-solid-svg-icons';
import { faShield } from '@fortawesome/free-solid-svg-icons';
import { faCrosshairs } from '@fortawesome/free-solid-svg-icons';
import { faSkull } from '@fortawesome/free-solid-svg-icons';
import { Player } from '../models/Player';

library.add(faHeart, faShield, faCrosshairs, faSkull);

interface Props {
  players: Array<Player>;
  isLeft: boolean;
  teamClass: string;
}

defineProps<Props>();
</script>

<template>
  <div :class="['team-container', teamClass]">
    <div v-for="player in players" :key="player.id"
      :class="['player-container', isLeft ? 'player-container-red' : 'player-container-blue']">
      <div class="player-header">
        <div class="player-name">{{ player.name }}</div>
        <div class="player-health">
          <FontAwesomeIcon :icon="faHeart" :style="{ 'font-size': '20px' }"/> {{ player.health }}
          <FontAwesomeIcon :icon="faShield" :style="{ 'font-size': '20px' }"/> {{ player.hev }}
        </div>
      </div>
      <div class="player-stats">
        <div class="player-kills">
          <FontAwesomeIcon :icon="faCrosshairs" :style="{ 'font-size': '20px' }"/> {{ player.frags }}
        </div>
        <div class="player-deaths">
          <FontAwesomeIcon :icon="faSkull" :style="{ 'font-size': '20px' }"/> {{ player.deaths }}
        </div>
        <div class="player-weapon">
          <img :src="`src/assets/weapons/${player.weapon}.png`" class="weapon-image" />
          <div class="weapon-stats">
            {{ player.clip === -1 && ['weapon_gauss', 'weapon_egon', 'weapon_snark',
              'weapon_hornetgun', 'weapon_tripmine'].includes(player.weapon) ? player.ammo : `${player.clip}/${player.ammo}` }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.team-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 50%;
  overflow-y: auto;
  max-height: 100%;
}

.player-container-red {
  font-size: 16px;
  background: rgba(204, 51, 51, 0.8);
  color: #fff;
  border-radius: 1px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  width: 350px;
  height: 90px;
  margin: 5px;
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.player-container-blue {
  font-size: 16px;
  background: rgba(0, 51, 204, 0.8);
  color: #fff;
  border-radius: 1px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  width: 350px;
  height: 90px;
  margin: 5px;
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.player-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #0033cc;
  padding: 10px;
  border-radius: 1px;
}

.player-name {
  font-size: 20px;
  font-weight: bold;
}

.player-health {
  font-size: 20px;
}

.player-stats {
  display: flex;
  padding: 5px 0;
}

.player-kills {
  font-size: 20px;
  font-weight: bold;
  margin-left: 15px;
  margin-right: 20px;
  padding-top: 8px;
}

.player-deaths {
  font-size: 20px;
  padding-top: 8px;
  font-weight: bold;
}

.weapon-image {
  position: absolute;
  right: 10px;
  bottom: 14px;
  width: 40px;
  height: auto;
  object-fit: contain;
}

.weapon-stats {
  font-size: 12px;
  color: #fff;
  position: absolute;
  right: 10px;
  bottom: 2px;
  background: rgba(0, 0, 0, 0.6);
  padding: 2px 5px;
  border-radius: 4px;
}

.team-red {
  align-items: flex-start;
}

.team-blue {
  align-items: flex-end;
}

.team-red .player-header {
  background-color: rgba(204, 51, 51, 0.9);
}

.team-blue .player-header {
  background-color: rgba(0, 51, 204, 0.9);
}
</style>