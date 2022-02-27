import { initializeApp } from "https://www.gstatic.com/firebasejs/9.6.7/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.6.7/firebase-analytics.js";

const firebaseConfig = {
    apiKey: "AIzaSyAuzrEDkvROHsbLHchC8tPsauRtcTqrZSQ",
    authDomain: "agro-app-6b445.firebaseapp.com",
    projectId: "agro-app-6b445",
    storageBucket: "agro-app-6b445.appspot.com",
    messagingSenderId: "735758556284",
    appId: "1:735758556284:web:8499b7351d97c0b3b8bdf9",
    measurementId: "G-FBZ7K0479V"
};

const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);