(function counterPlugin() {
    const options = {
        video_id_number: Number(document.querySelector('#video_id').innerHTML),
        path: document.querySelector('#counter_path').innerHTML
    }
    function sendInformation(data, destinationURL) {

        var request = new XMLHttpRequest();
        request.open('POST', destinationURL, true);
        request.setRequestHeader('Content-Type', 'application/json');
        
        //check for error/success status - in this case we know it will fail 
        request.onreadystatechange = function (oEvent) {  
            if (request.readyState === 4 && request.status === 200) {  
                //log success
                console.log(request.responseText)  
            } else {  
                //log error
                console.log('Failed - Error: ' + request.statusText);  
            }  
        }; 	

        request.send(data);
    }

    videojs('my-video').ready(function(){

        let thisVideo = this,
            destinationURL = options.path,
            firstPlay = false,
            videoInfo = {
                v_id: String(options.video_id_number),
                view: "false",
            }
        
        //action when video resumes
        thisVideo.on('play', function(e) {
            
            //if user is not seeking video
            if(!thisVideo.seeking()) {
                
                //if it's the first time user press play
                if(!firstPlay) {
                    
                    //track it using a variable and add a view
                    firstPlay = true;
                    videoInfo.view = "true"

                    data = JSON.stringify(videoInfo)
                    //send information through http request
                    sendInformation(data, destinationURL);
                } 
                            
            }
        });

    });
})()