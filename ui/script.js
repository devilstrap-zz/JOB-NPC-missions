var displayTextTime = 5000

const npcmissions = new Vue({
    el: "#npcmissions",

    data: {
        // Shared
        ResourceName: "npcmissions",
        showMissionsSelector: false,
        missionsList : [],

    },

    methods: {

        // START OF MAIN MENU

        OpenMissionsMenu() {
            this.showMissionsSelector    = true;
        },

        CloseMissionsMenu() {
            axios.post(`https://${this.ResourceName}/CloseMenu`, {}).then((response) => {
                this.showMissionsSelector    = false;
            }).catch((error) => { });
        },

        ChooseSurvival() {
            axios.post(`https://${this.ResourceName}/ChooseSurvival`, {}).then((response) => {
                this.showMissionsSelector    = false;
            }).catch((error) => { });
        },
    },
});

const notification = new Vue({
    el: "#notification",
    data: {
        element: null,
        showing : false,
        text : "",
        ResourceName: "npcmissions"
    },
    methods: {

        ShowNotification() {
            this.showing = true;
        },

        CloseNotification() {
            axios.post(`https://${this.ResourceName}/CloseMenu`, {}).then((response) => {
                this.showing    = false;
            }).catch((error) => { });
        }
    }
});

// Listener from Lua CL
document.onreadystatechange = () => {
    if (document.readyState == "complete") {
        window.addEventListener("message", (event) => {
            if (event.data.type == "openMenu") {
                npcmissions.$data.missionsList = event.data.missions;
                npcmissions.OpenMissionsMenu();
            } else if (event.data.type == "notif") {
                if (event.data.time != null) {
                    displayTextTime = event.data.time;
                }
                element = document.getElementById("notification")
                addClass(element, "slide")
                notification.$data.text = event.data.text;
                ShowNotification();
            } else if (event.data.type == "unnotif") {
                notification.CloseNotification();
            }
        });
    }
}

const ShowNotification = async () => {
    element = document.getElementById("notification")
    notification.showing = true;
    await sleep(displayTextTime);
    removeClass(element, "slide");
    addClass(element, "unslide");
    await sleep(1000);
    notification.CloseNotification();
    await sleep(100);
    removeClass(element, "unslide");
};

const sleep = (ms) => {
    return new Promise((resolve) => setTimeout(resolve, ms));
};

const removeClass = (element, name) => {
    if (element.classList.contains(name)) {
        element.classList.remove(name);
    }
};

const addClass = (element, name) => {
    if (!element.classList.contains(name)) {
        element.classList.add(name);
    }
};
