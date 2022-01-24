<template>
    <div class="flex gap-5 flex-col">
        <div v-for="record in records" v-bind:key="record.fingerprint"
            class="bg-gray-800 text-gray-100 rounded p-5">
            <p>Title: {{record.title}}</p>
            <p>Artist: {{record.artist}}</p>
            <p>Price: {{formatPrice(record.price)}} Ether</p>
            <p>Year: {{record.year}}</p>
            <p>Genre: {{record.genre}}</p>
            <p>Holder: {{record.holder}}</p>
            <p>For sale: {{record.is_for_sale}}</p>
            <p>Fingerprint: {{record.fingerprint}}</p>
            <button v-if="record.is_for_sale && record.holder !== activeAccount"
                class="p-3 bg-pink-700 mt-2"
                @click="buyRecord(record.fingerprint, record.price)">
                Purchase
            </button>
            <div v-if="record.holder === activeAccount">
                <button v-if="!record.is_for_sale"
                    class="p-3 bg-pink-700 mt-2"
                    @click="setIsForSale(record.fingerprint, true)">
                    List for sale
                </button>
                <button v-if="record.is_for_sale"
                    class="p-3 bg-pink-700 mt-2"
                    @click="setIsForSale(record.fingerprint, false)">
                    Change status to not for sale
                </button>
                <!-- Change price -->
                <div class="mt-2">
                    <label for="price"></label>
                    <input type="number" v-model="record.price" class="p-3 bg-gray-100 text-gray-800" />
                    <button class="p-3 bg-pink-700 mt-2"
                        @click="setPrice(record.fingerprint, record.price)">
                        Update price
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
    name: "RecordList",
    data() {
        return {
            records: [],
            recordList: [],
            newPrice: 0,
        }
    },
    computed: {
        ...mapGetters('drizzle', ['drizzleInstance']),
        ...mapGetters('accounts', ['activeAccount', 'activeBalance']),
    },
    async mounted() {
        this.recordList = await this.drizzleInstance.contracts.Audio.methods.getRecordList().call();

        for (let key of this.recordList) {
            let record = await this.drizzleInstance.contracts.Audio.methods.getRecord(key).call();
            this.records.push({
                artist: record.artist,
                title: record.title,
                price: record.price,
                year: record.year,
                genre: record.genre,
                uri: record.uri,
                holder: record.holder,
                is_for_sale: record.is_for_sale,
                fingerprint: record.fingerprint,
            });
        }
    },
    methods: {
        buyRecord(fingerprint, price) {
            this.drizzleInstance.contracts.Audio.methods.buyRecord(fingerprint).send({
                from: this.activeAccount,
                value: price
            });
        },
        setIsForSale(fingerprint, isForSale) {
            this.drizzleInstance.contracts.Audio.methods.setIsForSale(fingerprint, isForSale).send({
                from: this.activeAccount
            });
        },
        setPrice(fingerprint, price) {
            this.drizzleInstance.contracts.Audio.methods.setPrice(fingerprint, price).send({
                from: this.activeAccount
            });
        },
        formatPrice(price) {
            return this.drizzleInstance.web3.utils.fromWei(price, 'ether');
        }
    }

}
</script>

<style>

</style>