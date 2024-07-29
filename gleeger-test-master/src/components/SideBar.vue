<template>
  <v-navigation-drawer 
    v-model="drawer"
    :mini-variant="mini"
    width="316px"
    permanent
    color="indigo lighten-5"
  >
    <v-list dense nav>
      <v-btn
        icon
        @click.stop="mini = !mini"
      >
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
      </v-btn>
      <v-list-item-group
        v-model="value"
        active-class="ch-currentbg"
      >
        <v-list-item 
          v-for="(item, i) in items"
          :key="i"
          class="py-1 my-5"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          &nbsp;&nbsp;&nbsp;

          <v-list-item-title 
            class="font-weight-light text-subtitle-1"
          >
            <span>{{ item.title }}</span>
          </v-list-item-title>

          <v-list-item-action v-if="item.title === 'Identity Verification'">
            <v-icon color="#69F0AE">
              {{ item.action }}
            </v-icon>
          </v-list-item-action>

          <v-list-item-action v-else-if="item.title === 'Security'">
            <v-icon color="#FF5252">
              {{ item.action }}
            </v-icon>
          </v-list-item-action>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
  export default {
    name: 'SideBar',

    data: () => ({
      drawer: true,
      mini: false,
      items: [
        { title: 'Accounts', icon: 'mdi-account', action: '' },
        { title: 'Activities', icon: 'mdi-monitor', action: '' },
        { title: 'API Management', icon: 'mdi-clipboard-text', action: '' },
        { title: 'Address Management', icon: 'mdi-home', action: '' },
        { title: 'Identity Verification', icon: 'mdi-key-variant', action: 'mdi-check-circle' },
        { title: 'Preferences', icon: 'mdi-border-color', action: '' },
        { title: 'Security', icon: 'mdi-lock', action: 'mdi-alert-circle' },
      ],
      value: 0,
    }),
  }
</script>

<style>
.ch-currentbg {
  background-color: #2962FF;
  color: white !important;
}
</style>
