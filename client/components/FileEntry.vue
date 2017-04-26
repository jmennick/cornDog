<template>
  <input type="file" @change="change" :multiple="multiple">
</template>

<script>
import {forEach, map, pullAt, every} from 'lodash'

const INITIAL_STATUS = 'initial'
const SUCCESS_STATUS = 'success'
const isCompleted = (p) => p === SUCCESS_STATUS

export default {
  props: {
    multiple: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    change ({target: {files}}) {
      if (!files) { return }
      // build initial vars
      this.files = []
      this.providedFiles = files
      this.status = map(files, f => INITIAL_STATUS)
      this.readers = map(files, f => new FileReader())
      // send event indicating start of loading
      this.$emit('loading', this.providedFiles)
      // go through each file and convert to data
      forEach(files, this.handleFile)
    },
    handleFile (file, index) {
      const reader = this.readers[index]
      reader.addEventListener('load', (event) => {
        this.handleLoad(file, reader, index, event)
      }, false)
      if (file) {
        reader.readAsDataURL(file)
      }
    },
    handleLoad ({name, type}, {result}, index, event) {
      this.status[index] = SUCCESS_STATUS
      this.files[index] = {name, mime_type: type, data: result}
      if (every(this.status, isCompleted)) {
        this.$emit('completed', this.files)
      }
      pullAt(this.reader, index)
    }
  },
  data: () => ({
    status: [],
    readers: [],
    providedFiles: [],
    files: []
  })
}
</script>
