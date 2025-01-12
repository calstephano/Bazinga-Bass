import sounddevice as sd
import json
import logging
import subprocess
import pygame
from vosk import Model, KaldiRecognizer

# Set up logging to match the format from `run.py`
logging.basicConfig(level=logging.INFO)

# Paths
model_path = "/home/calstephano/Bazinga-Bass/src/models/vosk-model-small-en-us-0.15"
activate_sound = "/home/calstephano/Bazinga-Bass/assets/activate.wav"

def wait_for_wake():
    """
    Continuously listens for the wake word 'Sheldon'.
    Logs a message when the wake word is detected and activates the system.
    """
    # Load the pre-trained Vosk model
    model = Model(model_path)

    # Create a recognizer with a sample rate of 16,000 Hz
    recognizer = KaldiRecognizer(model, 16000)

    # Open an audio input stream (16kHz, mono, 16-bit audio)
    with sd.RawInputStream(samplerate=16000, blocksize=4000, dtype='int16', channels=1) as stream:
        logging.info("Listening for 'Sheldon'...")

        while True:
            # Read audio data from the stream in chunks
            audio_chunk = stream.read(4000)                 # Read ~0.25 seconds of audio
            if recognizer.AcceptWaveform(audio_chunk[0]):   # Process the audio chunk immediately
                result = json.loads(recognizer.Result())    # Convert JSON string to Python dictionary
                text = result.get("text", "").lower()       # Get the recognized text (convert to lowercase)
                
                # Activate upon wake word
                if "sheldon" in text:
                    logging.info("Wake word 'Sheldon' detected.")
                    activate()
                    break
        logging.info("Stopping audio stream...")

def activate():
    """
    Activates the system by playing a sound and triggering the servo control.
    """
    # Run the servo control script
    subprocess.run(["./src/cpp/turn_head"])

    # Play the activation sound
    pygame.mixer.init()
    pygame.mixer.Sound(activate_sound).play()

if __name__ == "__main__":
    wait_for_wake()
