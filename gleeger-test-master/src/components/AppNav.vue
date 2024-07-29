<template>
  <v-toolbar color="indigo lighten-5" height="84px" flat>
    <v-toolbar-items>
      <v-container>
        <v-row align="start">
          <v-col cols="12" md="4">
            <v-img
              v-bind:src="require('../../src/assets/sparrow-logo.png')"
              max-width="150px"
              max-height="64px"
            />
          </v-col>
          <v-col class="hidden-md-and-down" cols="12" sm="4">
            <v-row class="pl-3 pt-4">
              <v-icon color="#FFA000">mdi-bitcoin</v-icon>
              &nbsp;
              <span>Bitcoin</span>
            </v-row>
            <v-row>
              <span class="pl-4 font-weight-light text-h6">88,888</span>
              <span class="pt-2 font-weight-light text-caption">.88</span>
            </v-row>
          </v-col>
          <v-col class="hidden-md-and-down" cols="12" sm="4">
            <v-row class="pl-3 pt-4">
              <v-icon color="#9FA8DA">mdi-ethereum</v-icon>
              &nbsp;
              <span>Ethereum</span>
            </v-row>
            <v-row>
              <span class="pl-4 font-weight-light text-h6">88,888</span>
              <span class="pt-2 font-weight-light text-caption">.88</span>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
    </v-toolbar-items>

    <v-spacer></v-spacer>
    
    <div name="scrollable" class="d-flex overflow-x-auto">
      <v-toolbar-items
        v-for="(item, i) in toolbarItems"
        :key="i"
      >
        <div class="mx-1" v-if="item.title === 'Account'">
          <v-btn icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-btn>
        </div>
        <div class="mx-1" v-else-if="item.title === 'Earth'">
          <v-btn icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-btn>
        </div>
        <div class="mx-1 mt-2" v-else-if="item.title === 'Settlement Price'">
          <v-btn rounded outlined color="blue">
            <span class="font-weight-medium text-caption">
              Settlement Price
            </span>
          </v-btn>
        </div>
        <div class="mx-1 my-2" v-else-if="item.title === 'vertical'">
          <v-divider class="profile-divider" vertical />
        </div>
        <div class="mx-1 mt-2" v-else>
          <v-btn text rounded>
            <span class="font-weight-medium text-caption">
              {{ item.title }}
            </span>
          </v-btn>
        </div>
      </v-toolbar-items>
    </div>
  </v-toolbar>
</template>

<script>
export default {
  name: 'AppNav',

  data: () => ({
    toolbarItems: [
      { title: 'ConvertNOW', icon: '' },
      { title: 'Options', icon: '' },
      { title: 'Funds', icon: '' },
      { title: 'Support', icon: '' },
      { title: 'Settlement Price', icon: '' },
      { title: 'Account', icon: 'mdi-account' },
      { title: 'vertical', icon: '' },
      { title: 'Earth', icon: 'mdi-earth' },
    ]
  }),
};
</script>

<style>
.profile-divider {
  border-width: 1px !important;
}
</style>
