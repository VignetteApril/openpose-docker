import sys
import cv2
import os
from sys import platform
import argparse

try:
    # Import OpenPose
    dir_path = os.path.dirname(os.path.realpath(__file__))
    try:
        sys.path.append('/usr/local/python')
        from openpose import pyopenpose as op
    except ImportError as e:
        print('Error: OpenPose library could not be found. Did you enable `BUILD_PYTHON` in CMake and have this Python script in the right folder?')
        raise e

    # Flags
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_folder", default="/openpose/models/", help="Path to the OpenPose models.")
    args = parser.parse_known_args()

    # Parameters
    params = dict()
    params["model_folder"] = args[0].model_folder
    params["face"] = True
    params["face_detector"] = 2
    params["body"] = 0

    # Initialize OpenPose
    opWrapper = op.WrapperPython()
    opWrapper.configure(params)
    opWrapper.start()

    # Open webcam
    cap = cv2.VideoCapture(0)  # 0 is the default webcam

    if not cap.isOpened():
        print("Error: Could not open webcam.")
        sys.exit(-1)

    print("Press 'q' to exit.")

    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Could not read frame from webcam.")
            break

        # Create new datum
        datum = op.Datum()
        datum.cvInputData = frame

        # Process the image
        opWrapper.emplaceAndPop([datum])

        # Display face keypoints
        if datum.faceKeypoints is not None:
            print("Face keypoints: \n", datum.faceKeypoints)

        # Show the frame with keypoints
        cv2.imshow("OpenPose Face Keypoints", datum.cvOutputData)

        # Exit on 'q'
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # Release resources
    cap.release()
    cv2.destroyAllWindows()

except Exception as e:
    print(e)
    sys.exit(-1)
