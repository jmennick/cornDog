import {mapState, mapMutations} from 'vuex'
import {saveData} from '~store/resourceForm'

export default {
  computed: {
    ...mapState({
      resource: ({resourceForm}) => resourceForm.modalData
    })
  },
  methods: {
    ...mapMutations('resourceForm', {saveData})
  }
}
