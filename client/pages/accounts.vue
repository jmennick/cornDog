<template>
    <!--<section class="container">-->
    <v-container>
        <form>
            <v-row>
                <v-grid s12>
                    <h1 class="title">
                        Chart of Accounts
                    </h1>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Account Name</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input name="name" id="accountName" type="text" placeholder="Account Name">
                        <!--<label for="accountName">Account Name</label>-->
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Account Type</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <select name="type" type="text" id="accountType" placeholder="Account Type">
                            <option value="" disabled selected>Choose your option</option>
                            <option value="asset">Asset</option>
                            <option value="liability">Liability</option>
                            <option value="oe">Owners Equity</option>
                        </select>
                        <!--<label>Materialize Select</label>-->
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Normal Side</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <select name="normalSide" id="normalSide" placeholder="Normal Side">
                            <option value="right">Right</option>
                            <option value="left">Left</option>
                        </select>
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Initial Balance</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input name="balance" id="initialBalance" type="number" placeholder="0.00">
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Account Number</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input name="accountNumber" id="accountNumber" placeholder="101" type="number">
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Order</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input name="order" id="accountOrder" placeholder="Order" type="text">
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Added By</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input name="author" id="author" placeholder="Added by" type="text">
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Date Added</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input name="date" id="dateInput" placeholder="mm/dd/yy" type="date">
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Active</h5>
                </v-grid>
                <v-grid s6>
                    <!--Add checkbox-->
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Sub-Group</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <select name="subGroup" id="subGroup" placeholder="Sub-Group">
                            <option value="current">Current Asset</option>
                            <option value="long">Long-Term Asset</option>
                        </select>
                    </div>
                </v-grid>
            </v-row>
            <v-row>
                <v-grid s6>
                    <h5>Description</h5>
                </v-grid>
                <v-grid s6>
                    <div class="input-field col s6">
                        <input id="description" placeholder="Description" name="description" type="text">
                    </div>
                </v-grid>
            </v-row>
        </form>
    </v-container>
    <!--</section>-->
</template>

<style scoped>
    .title {
        margin-top: 50px;
    }

    .button {
        margin-top: 50px;
    }

    select {
        display: block !important;
    }
</style>
