<template>
  <v-app>
    <AppNav />

    <v-main>
      <div class="main-height d-flex">
        <div name="sidebar">
          <SideBar />
        </div>
        <MainBody />
      </div>
    </v-main>
  </v-app>
</template>

<script>
import AppNav from './components/AppNav';
import SideBar from './components/SideBar';
import MainBody from './components/MainBody';

export default {
  name: 'App',

  components: {
    AppNav,
    SideBar,
    MainBody,
  },

  data: () => ({
    //
  }),
};
</script>

<style scoped>
.main-height {
  height: 100%;
}
</style>
