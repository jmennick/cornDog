<template>
  <div>
    <b-navbar type="inverse" variant="success" class="d-flex flex-row align-items-center fixed-top secondary-nav text-white">
      <b-button variant="success" class="p-2 mr-auto"><icon name="refresh" :spin="true"></icon> Refresh</b-button>
      <span class="p-2 text-lg h5 no-bottom-margin">Accounts</span>
      <b-button variant="success" class="p-2 ml-auto"><icon name="plus"></icon> Add Account</b-button>
    </b-navbar>
    <div class="content-container">
      <table class="table table-striped no-bottom-margin">
        <thead>
          <tr>
            <th>Code</th>
            <th>Name</th>
            <th>Kind</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="a in accounts">
            <td>{{a.code}}</td>
            <td>{{a.name}}</td>
            <td>{{a.kind}}</td>
            <td class="d-flex justify-content-end td-actions"><div class="btn-toolbar">
              <b-button class="mr-2"><icon name="edit"></icon> Edit</b-button>
              <b-button><icon name="ban"></icon> Deactivate</b-button>
            </div></td>
          </tr>
        </tbody>
      </table>
    </div>
    <b-navbar type="inverse" variant="inverse" class="fixed-bottom d-flex flex-row align-items-center">
      <!-- <b-button variant="inverse" class="p-2">Blah</b-button> -->
      <b-button variant="inverse" class="p-2 mr-auto"><icon name="filter"></icon> Sort &amp; Filter</b-button>
      <b-pagination class="p-2 no-padding" size="md" :total-rows="100" :per-page="10" v-model="currentPage"></b-pagination>
      <!-- <b-button variant="inverse" class="p-2 ml-auto">Blah</b-button> -->
      <b-dropdown text="Reports" variant="inverse" class="p-2 ml-auto no-padding" dropup right>
        <a class="dropdown-item">First Report</a>
        <a class="dropdown-item">Second Report</a>
        <a class="dropdown-item">Third Report</a>
      </b-dropdown>
    </b-navbar>
  </div>
</template>

<script>
export default {
  data: ()=> ({
    currentPage: 1,
    accounts: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25].map((i)=> ({
        code: 101,
        name: 'Cash',
        kind: 'Current Asset'
      }))
  })
}
</script>
