import {mapState, mapGetters} from 'vuex'
import {get} from 'lodash'

import {
  showRouteName
} from '~store/resource'

import {
  viewStateIsSuccess
} from '~store/resourceForm'

export default {
  computed: {
    ...mapState({
      showRouteArticle: ({resource}) => resource.showRouteArticle,
      resourceFormInputData: ({resourceForm}) => resourceForm.modalData,
      resourceFormResultData: ({resourceForm}) => resourceForm.resultData
    }),
    ...mapGetters('resourceForm', {
      formStateIsSuccess: viewStateIsSuccess
    }),
    ...mapGetters('resource', {
      showRouteName
    })
  },
  watch: {
    formStateIsSuccess (newValue) {
      if (newValue === true) {
        const dataID = get(this, 'resourceFormInputData.id')
        if (dataID === null) {
          // this is a new resource (therefore a create)
          // should forward to the newly-created resource
          this.$router.push({
            name: this.showRouteName,
            params: {[this.showRouteArticle]: get(this, 'resourceFormResultData.id')}
          })
        } else {
          // this is an existing resource (therefore an update)
          // should refresh the data under the hood
          this.$store.dispatch('resource/fetch')
        }
      }
    }
  }
}
