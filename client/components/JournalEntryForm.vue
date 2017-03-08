<template>
  <div class="form-body-inner">
    <table class="table table-striped">
      <thead>
        <tr>
          <th>Account</th>
          <th>Date</th>
          <th class="text-right" style="padding-right: 40px">Debit</th>
          <th class="text-right" style="padding-right: 40px">Credit</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, $index) in journalEntry.items">
          <td>
            <b-form-select v-model="item.account_id" :options="possbleAccounts" :defaultOption="defaultAccount">
            </b-form-select>
          </td>
          <td>
            <b-form-input type="date" style="width: 170px" v-model="item.date"></b-form-input>
          </td>
          <td>
            <b-form-input type="number" class="text-right float-right" :formatter="currencyFormatter" lazy-formatter style="width: 130px" v-model="item.left_value" @input="updateItem($index,'left_value',$event)" :disabled="itemIsRight(item)"></b-form-input>
          </td>
          <td>
            <b-form-input type="number" class="text-right float-right" :formatter="currencyFormatter" lazy-formatter style="width: 130px" v-model="item.right_value" @input="updateItem($index,'right_value',$event)" :disabled="itemIsLeft(item)"></b-form-input>
          </td>
          <td>
            <b-button variant="danger" @click="removeItem($index)"><icon name="remove" :disabled="journalEntry.items.length<=1"></icon></b-button>
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <th>Total</th>
          <th></th>
          <th class="text-right" style="padding-right: 40px">{{currencyFormatter(totalDebit)}}</th>
          <th class="text-right" style="padding-right: 40px">{{currencyFormatter(totalCredit)}}</th>
          <th></th>
        </tr>
      </tfoot>
    </table>
    <b-button variant="link" size="sm" @click="addItem">Add Item</b-button>
  </div>
</template>

<script>
import format from 'format'
import apiClient from '~plugins/apiClient'
import {mapState, mapMutations} from 'vuex'
import ItemsTable from '~components/journal_entries/ItemsTable'
import resourceFormMixin from '~assets/js/mixins/resourceFormMixin'
import {enableSaving, disableSaving} from '~store/resourceForm'

export default {
  mixins: [resourceFormMixin],
  components: {
    ItemsTable
  },
  computed: {
    ...mapState({
      journalEntry: ({resourceForm})=> resourceForm.modalData
    }),
    totalDebit() {
      return this.journalEntry.items.reduce((acc,val)=> {
        if (this.itemIsLeft(val)) {
          return acc+val.left_value
        } else {
          return acc
        }
      }, 0)
    },
    totalCredit() {
      return this.journalEntry.items.reduce((acc,val)=> {
        if (this.itemIsRight(val)) {
          return acc+val.right_value
        } else {
          return acc
        }
      }, 0)
    },
    isBalanced() {
      return (this.totalDebit == this.totalCredit) && (this.totalDebit > 0)
    }
  },
  beforeCreate() {
    apiClient.findAll('account', {filter: {active: true}}).then(accounts=> {
      this.possbleAccounts = accounts.map(a=> ({text: `${a.code} ${a.name}`, value: a.id}))
    })
  },
  // mounted() {
  //   this.handleIsBalanced(this.isBalanced)
  // },
  data: ()=> ({
    fields: {
      date: {label: 'Date'},
      credit: {label: 'Credit'},
      debit: {label: 'Debit'}
    },
    defaultAccount: {
      text: 'Select an Account',
      value: null
    },
    possbleAccounts: []
  }),
  methods: {
    currencyFormatter: (val)=> {
      if (val == 0 || !!val) {
        return format('%0.2f', val)
      } else {
        return null
      }
    },
    itemIsLeft: (item)=> !!item.left_value,
    itemIsRight: (item)=> !!item.right_value,
    addItem() {
      let resource = this.resource
      resource.items.push({
        left_value: null,
        right_value: null
      })
      this.saveData(resource)
    },
    removeItem($index) {
      let resource = this.resource
      resource.items.splice($index, 1)
      this.saveData(resource)
    },
    updateItem($index, pname, value) {
      let resource = this.resource
      let item = resource.items[$index]
      item[pname] = value
      resource.items[$index] = item
      this.saveData(resource)
    },
    handleIsBalanced(value) {
      if (value) {
        this.enableSaving()
      } else {
        this.disableSaving()
      }
    },
    ...mapMutations('resourceForm', {enableSaving, disableSaving})
  },
  watch: {
    isBalanced(newValue) {
      this.handleIsBalanced
    }
  }
}
</script>
