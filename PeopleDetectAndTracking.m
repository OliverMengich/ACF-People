detector = peopleDetectorACF;
tracker = vision.PointTracker('MaxBidirectionalError',1);
camera = webcam;
videoplayer = vision.DeployableVideoPlayer();


while true
    image = camera.snapshot();
    frame = step(image);
    [bbox,scores] = detect(detector,frame);
    if ~isempty(bbox)
        points = detectMinEigenFeatures(frame,'ROI',bbox);
        initialize(tracker,points.Location,frame);
        [points,validity] = tracker(frame);
        out = insertMarker(frame,points(validity,:),'+');
        step(videoplayer,out);
    end
    step(videoplayer,frame);  
end