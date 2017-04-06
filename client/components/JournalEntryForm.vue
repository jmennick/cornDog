<template>
  <div class="form-body-inner">
    <div class="container-fluid" style="margin-top: 15px">
      <!-- <b-form-fieldset label="Name" horizontal>
        <b-form-input v-model="journalEntry.name" type="string"></b-form-input>
      </b-form-fieldset> -->
      <b-form-fieldset label="Date *" :state="!journalEntry.date?'danger':null" horizontal>
        <b-form-input v-model="journalEntry.date" @input="updateProp('date',$event)" type="date" placeholder="Date"></b-form-input>
      </b-form-fieldset>
    </div>
    <table class="table table-striped">
      <thead>
        <tr>
          <th>Account</th>
          <th class="text-right" style="padding-right: 40px">Debit</th>
          <th class="text-right" style="padding-right: 40px">Credit</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, $index) in journalEntry.items">
          <td :class="[!item.account_id?'has-danger':null]">
            <b-form-select v-model="item.account_id" :options="availableAccounts" :defaultOption="defaultAccount" @input="updateItem($index,'account_id',$event)">
            </b-form-select>
          </td>
          <td :class="[(!item.left_value && !itemIsRight(item))?'has-danger':null]">
            <b-form-input type="number" class="text-right float-right" :formatter="currencyFormatter" lazy-formatter v-model="item.left_value" @input="updateItem($index,'left_value',$event)" :disabled="itemIsRight(item) && !itemIsLeft(item)"></b-form-input>
          </td>
          <td :class="[(!item.right_value && !itemIsLeft(item))?'has-danger':null]">
            <b-form-input type="number" class="text-right float-right" :formatter="currencyFormatter" lazy-formatter v-model="item.right_value" @input="updateItem($index,'right_value',$event)" :disabled="itemIsLeft(item) && !itemIsRight(item)"></b-form-input>
          </td>
          <td>
            <b-button variant="danger" @click="removeItem($index)" :disabled="onlyOneItemLeft"><icon name="remove"></icon></b-button>
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <th>Total</th>
          <th class="text-right" style="padding-right: 40px">{{currencyFormatter(totalDebit)}}</th>
          <th class="text-right" style="padding-right: 40px">{{currencyFormatter(totalCredit)}}</th>
          <th></th>
        </tr>
      </tfoot>
    </table>
    <div class="container-fluid" style="margin-bottom: 15px">
      <b-button variant="success" @click="addItem">Add Item</b-button>
    </div>
  </div>
</template>

<script>
import format from 'format'
import {reject, isNumber, isString} from 'underscore'
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
          return acc + parseInt(val.left_value)
        } else {
          return acc
        }
      }, 0)
    },
    totalCredit() {
      return this.journalEntry.items.reduce((acc,val)=> {
        if (this.itemIsRight(val)) {
          return acc + parseInt(val.right_value)
        } else {
          return acc
        }
      }, 0)
    },
    availableAccounts() {
      const usedAccounts = this.journalEntry.items.map(i => i.account_id)
      return this.possibleAccounts.map(a => {
        if (usedAccounts.includes(a.value)) {
          return {...a, disabled: true}
        } else {
          return a
        }
      })
    },
    isBalanced() {
      if ((this.totalDebit != this.totalCredit) || (this.totalDebit <= 0)) {
        return false
      } else {
        return true
      }
    },
    isValid() {
      if (!this.journalEntry.date) {
        return false
      } else if (!this.isBalanced) {
        return false
      } else if (!this.journalEntry.items.every(this.itemIsValid)) {
        return false
      } else {
        return true
      }
    },
    onlyOneItemLeft() {
      return this.journalEntry.items.length==1
    }
  },
  beforeCreate() {
    apiClient.findAll('account', {filter: {active: true}}).then(accounts=> {
      this.possibleAccounts = accounts.map(a=> ({
        text: `${a.code} ${a.name}`,
        value: a.id
      }))
    })
  },
  mounted() {
    this.handleIsValid(this.isValid)
  },
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
    possibleAccounts: []
  }),
  methods: {
    currencyFormatter: (val)=> {
      if (isString(val) && !parseFloat(val)) {
        return null
      } else {
        return format('%0.2f', val)
      }
    },
    itemIsLeft: (item)=> {
      return !!item.left_value
    },
    itemIsRight: (item)=> {
      return !!item.right_value
    },
    addItem() {
      let resource = this.resource
      resource.items.push({
        account_id: null,
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
    updateProp(pname, value) {
      let resource = this.resource
      resource[pname] = value
      this.saveData(resource)
    },
    handleIsValid(value) {
      if (value) {
        this.enableSaving()
      } else {
        this.disableSaving()
      }
    },
    itemIsValid(item) {
      if (!item.account_id) {
        return false
      } else if (!item.left_value && !item.right_value) {
        return false
      } else {
        return true
      }
    },
    ...mapMutations('resourceForm', {enableSaving, disableSaving})
  },
  watch: {
    isValid(newValue) {
      this.handleIsValid(newValue)
    }
  }
}
</script>
