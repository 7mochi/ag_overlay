<template>
    <div id="error">Datos JSON no válidos</div>
  </template>
  
  <script>
  export default {
    name: 'Error',
  };
  </script>
  
  <style scoped>
  #error {
      color: red;
      font-size: 18px;
      font-weight: bold;
      position: absolute;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
  }
  </style>