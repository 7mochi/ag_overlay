<template>
    <div id="team-model-settings">
      <h3>Settings</h3>
      <div class="team-model">
        <label for="left-model">Left team model:</label>
        <input type="text" id="left-model" v-model="leftTeamModel" @input="updateTeamModel('left', leftTeamModel)" />
      </div>
      <div class="team-model">
        <label for="right-model">Right team model:</label>
        <input type="text" id="right-model" v-model="rightTeamModel" @input="updateTeamModel('right', rightTeamModel)" />
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, defineProps, watchEffect } from 'vue';
  
  const props = defineProps<{
    leftTeamModel: string;
    rightTeamModel: string;
    updateTeamModel: (team: string, model: string) => void;
  }>();
  
  const leftTeamModel = ref(props.leftTeamModel);
  const rightTeamModel = ref(props.rightTeamModel);
  
  watchEffect(() => {
    leftTeamModel.value = props.leftTeamModel;
    rightTeamModel.value = props.rightTeamModel;
  });
  </script>
  
  <style scoped>
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
  