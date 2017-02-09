module.exports = {
    /*
     ** Headers of the page
     */
    head: {
        title: 'Corndog',
        meta: [
            {charset: 'utf-8'},
            {name: 'viewport', content: 'width=device-width, initial-scale=1'},
            {hid: 'description', content: "Nuxt.js project"}
        ],
        link: [
            {rel: 'icon', type: 'image/x-icon', href: 'favicon.ico'},
            {rel: 'stylesheet', href: 'http://fonts.googleapis.com/icon?family=Material+Icons'},
            {rel: 'stylesheet', href: 'https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.css'},
            {rel: 'stylesheet', href: 'https://code.getmdl.io/1.3.0/material.indigo-pink.min.css'}
        ],
        scripts: [
            {src: 'https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js'},
            {src: 'https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.js'},
            {src: 'https://code.getmdl.io/1.3.0/material.min.js'}
        ]
    },
    /*
     ** Global CSS
     */
    css: ['~assets/css/main.css'],
    /*
    ** Plugins
     */
    plugins: ['~plugins/material'],
    /*
     ** Customize the progress-bar color
     */
    loading: {color: '#3B8070'}
}
