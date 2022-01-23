<template>
    <div class="my-5 flex flex-col gap-4">
        <!-- Upload audio file -->
        <input class="block" type="file" accept="audio/*"  @change="onFileChange" />
        <input class="block p-2 border" type="text" v-model="artist" placeholder="Artist" required>
        <input class="block p-2 border" type="text" v-model="title" placeholder="Title" required>
        <input class="block p-2 border" type="number" v-model="year" placeholder="Year" required>
        <input class="block p-2 border" type="text" v-model="genre" placeholder="Genre" required>
        <input class="block p-2 border" type="number" v-model="price" placeholder="Price" required>
        <div>
            <span>Is for sale: </span> <input class="p-2 border" type="checkbox" v-model="is_for_sale" />
        </div>

        <div class="flex justify-left">
            <button class="p-2 border text-gray-100 bg-gray-800" @click="registerRecord">Register</button>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { sha256 } from 'js-sha256'

export default {
    name: 'RegisterRecording',
    data() {
        return {
            artist: '',
            title: '',
            price: '',
            year: '',
            genre: '',
            uri: '',
            is_for_sale: '',
            fingerprint: '',
        }
    },
    computed: {
        ...mapGetters('accounts', ['activeAccount']),
        ...mapGetters('drizzle', ['drizzleInstance']),
    },
    methods: {
        registerRecord() {
            this.drizzleInstance.contracts['Audio'].methods['registerRecord'].cacheSend(
                this.title,
                this.artist,
                this.genre,
                this.year,
                this.price,
                this.is_for_sale,
                this.fingerprint,
                this.uri                
            );

        },
        onFileChange(e) {
            const file = e.target.files[0];
            const reader = new FileReader();
            reader.onload = (e) => {
                sha256(e.target.result);
                this.fingerprint = `0x${sha256(e.target.result)}`;
            };
            reader.readAsDataURL(file);
        }
    },
}
</script>