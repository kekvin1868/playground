<template>
  <v-container fluid>
    <v-row class="mx-3 my-3">
      <v-col class="pl-14 pt-6" cols="12" md="5">
        <p 
          style="color: #2962FF"
          class="text-h2 font-weight-normal"
        >
          Welcome.
        </p>
      </v-col>
      <v-col class="pt-6" cols="12" md="7">
        <v-card class="user-status-info" rounded color="#2962FF">
          <v-row class="d-flex ml-1">
            <v-col cols="7" class="pb-0">
              <v-card-title class="py-0">
                <span class="overflow-x-auto text-subtitle-1 white--text ">
                  Email
                </span>
              </v-card-title>
            </v-col>
            <v-col cols="5" class="pb-0">
              <v-card-title class="py-0">
                <span class="overflow-x-auto text-subtitle-1 white--text">
                  Country
                </span>
              </v-card-title>
            </v-col>
          </v-row>

          <v-row class="d-flex ml-1">
            <v-col cols="7" class="py-0 i">
              <v-card-title class="py-0">
                <span class="overflow-x-auto font-weight-black white--text">
                  Test@sparrowexchange.com
                </span>
              </v-card-title>
            </v-col>
            <v-col cols="5" class="py-0">
              <v-card-title class="py-0">
                <span class="overflow-x-auto font-weight-black white--text">
                  IDN
                </span>
              </v-card-title>
            </v-col>
          </v-row>

          <v-row class="d-flex ml-1">
            <v-col cols="7" class="pb-0">
              <v-card-title class="pb-0">
                <span class="text-subtitle-1 white--text ">
                  User ID
                </span>
              </v-card-title>
            </v-col>
            <v-col cols="5" class="pb-0">
              <v-card-title class="pb-0">
                <span class="text-subtitle-1 white--text">
                  Joined Since
                </span>
              </v-card-title>
            </v-col>
          </v-row>

          <v-row class="d-flex ml-1">
            <v-col cols="7" class="py-0">
              <v-card-title class="py-0">
                <span class="font-weight-black white--text">
                  00ddd4c4-b0b3-4df3-a694
                </span>
              </v-card-title>
            </v-col>
            <v-col cols="5" class="py-0">
              <v-card-title class="py-0">
                <span class="font-weight-black white--text">
                  12 Feb 21
                </span>
              </v-card-title>
            </v-col>
          </v-row>

          <v-row class="d-flex ml-1">
            <v-col cols="7" class="pb-0">
              <v-card-title class="pb-0">
                <span class="text-subtitle-1 white--text ">
                  Account Status
                </span>
              </v-card-title>
            </v-col>
            <v-col cols="5" class="pb-0">
              <v-card-title class="pb-0">
                <span class="text-subtitle-1 white--text">
                  2FA Status
                </span>
              </v-card-title>
            </v-col>
          </v-row>

          <v-row class="d-flex ml-1">
            <v-col cols="7" class="py-0">
              <v-card-title class="pt-0">
                <v-icon color="green" class="mr-2">mdi-checkbox-blank-circle</v-icon>
                <span class="font-weight-black white--text">
                  Verified
                </span>
              </v-card-title>
            </v-col>
            <v-col cols="5" class="py-0">
              <v-card-title class="pt-0">
                <v-icon color="red" class="mr-2">mdi-checkbox-blank-circle</v-icon>
                <span class="font-weight-black white--text">
                  Disabled
                </span>
              </v-card-title>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>

    <v-container fluid class="mx-0">
      <v-row class="mx-3">
        <v-col class="pl-8 mt-2" cols="12" md="5">
          <v-list class="pt-0" dense>
            <v-list-item class="activity-list">
              <v-list-item-title>
                <span class="font-weight-light text-h4">
                  Last Login
                </span>
              </v-list-item-title>
              
              <v-btn text>
                <span 
                  style="color: #2962FF"
                  class="text-caption text-weight-light"
                >
                  See all activities
                </span>
              </v-btn>
            </v-list-item>

            <v-list-item class="activity-list">
              <v-divider></v-divider>
            </v-list-item>

            <v-list-item class="activity-list">
              <v-list-item-subtitle>
                <span>30 Jan 21, 16:28, Chrome Mac OS X</span>
              </v-list-item-subtitle>
            </v-list-item>
          </v-list>

          <v-list class="my-12" dense>
            <v-list-item class="activity-list">
              <v-list-item-title>
                <span class="font-weight-light text-h4">
                  My Product
                </span>
              </v-list-item-title>
            </v-list-item>

            <v-list-item class="activity-list mb-1">
              <v-divider></v-divider>
            </v-list-item>

            <v-list-item 
              v-for="(item, i) in products"
              :key="i"
            >
              <v-row align="center" class="mx-1"> 
                <v-col cols="9">
                  <v-row>
                    <v-col cols="12" class="pb-0">
                      <span class="font-weight-medium text-body-1">
                        {{ item.title }}
                      </span>
                    </v-col>
                    
                    <v-col cols="12" class="pt-0">
                      <span class="text-caption text--secondary">
                        {{ item.desc }}
                      </span>
                    </v-col>
                  </v-row>
                </v-col>
                <v-col cols="3">
                  <v-switch
                    v-model="item.value"
                  />
                </v-col>
              </v-row>
            </v-list-item>
          </v-list>
        </v-col>

        <v-col class="mt-2 pr-0" cols="12" md="7">
          <div class="mb-3">
            <span class="font-weight-light text-h4">
              Personal Account
            </span>
          </div>
          
          <v-data-table
            :headers="coinHeaders"
            :items="coins"
            :item-per-page="5"
            class="elevation-4"
          >
            <template v-slot:[`item.asset`]="{ item }">
              <span>
                <v-icon color="#2962FF" v-if="item.asset === 'SP$'">mdi-currency-usd</v-icon>
                <v-icon color="#FFCA28" v-else-if="item.asset === 'BTC'">mdi-bitcoin</v-icon>
                {{ item.asset }}
              </span>
            </template>
          </v-data-table>
          
        </v-col>
      </v-row>
    </v-container>
  </v-container>
</template>

<script>
export default {
  name: 'MainBody',

  data: () => ({
    coinHeaders: [
      { text: 'Assets', align: 'start', value: 'asset' },
      { text: 'Total', align: 'start', value: 'total' },
      { text: 'Available', align: 'start', value: 'available' },
      { text: 'Locked', align: 'start', value: 'lock' },
    ],
    coins: [
      { asset: 'SP$', total: 88888.88, available: 88888.88, lock: 88888.88 },
      { asset: 'BTC', total: 88888.88, available: 88888.88, lock: 88888.88 },
      { asset: 'BTC', total: 88888.88, available: 88888.88, lock: 88888.88 },
      { asset: 'BTC', total: 88888.88, available: 88888.88, lock: 88888.88 },
      { asset: 'BTC', total: 88888.88, available: 88888.88, lock: 88888.88 },
      { asset: 'BTC', total: 88888.88, available: 88888.88, lock: 88888.88 },
    ],
    products: [
      { title: 'ConvertNOW', desc: 'Required', value: 0 },
      { title: 'Options', desc: '', value: 0 },
      { title: 'Structured Products', desc: 'To change status please contact your Relationship Manager.', value: 0 },
    ],
  }),
};
</script>

<style scoped>
.v-list-item.activity-list {
  min-height: 20px;
}
</style>
