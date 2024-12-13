import psycopg2
import requests
import re
from collections import Counter

# Database connection parameters
db_params = {
    'dbname': 'postgres',
    'user': 'BUILDER',
    'password': 'Ser1ousPwd',
    'host': 'localhost',
    'port': '54321'
}

# Function to fetch lyrics from the API
def fetch_lyrics(artist, title):
    url = f"https://api.lyrics.ovh/v1/{artist}/{title}"
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json().get("lyrics", "")
    except requests.RequestException as e:
        print(f"Error fetching lyrics for '{title}' by {artist}: {e}")
        return None

# Connect to the PostgreSQL database
try:
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    print("Connected to the database successfully.")

    # Query to retrieve and display all songs from the 'songs' table
    cursor.execute("SELECT * FROM songs;")
    songs_table = cursor.fetchall()
    print("Songs table contents:")
    for song in songs_table:
        print(song)

    # Retrieve artist and title from the 'songs' table
    cursor.execute("SELECT song_title, singer FROM songs;")
    songs = cursor.fetchall()

    # Prepare the insertion SQL for 'songs_words' table
    insert_query = "INSERT INTO songs_words (song_title, word, word_count) VALUES (%s, %s, %s);"

    # Process each song
    for song_title, artist in songs:
        lyrics = fetch_lyrics(artist, song_title)
        if lyrics:
            # Split lyrics into words, convert to lowercase, and filter out non-alphabetic characters
            words = re.findall(r'\b\w+\b', lyrics.lower())

            # Count occurrences of each word
            word_counts = Counter(words)

            # Insert each unique word and its count into 'songs_words' table
            for word, count in word_counts.items():
                cursor.execute(insert_query, (song_title, word, count))

            # Commit after each song to save progress
            connection.commit()
            print(f"Inserted words for song: {song_title} by {artist}")
            print(f"Lyrics for '{song_title}':\n{lyrics}\n")

    # Remove words with fewer than four characters
    cursor.execute("DELETE FROM songs_words WHERE LENGTH(word) < 4;")
    connection.commit()
    print("Removed all words with length less than 4 characters.")

    # Query for top five most used words in 2023
    cursor.execute("""
        SELECT word, SUM(word_count) AS total_count
        FROM songs_words
        JOIN songs ON songs_words.song_title = songs.song_title
        WHERE song_year = 2023
        GROUP BY word
        ORDER BY total_count DESC
        LIMIT 5;
    """)
    top_words_2023 = cursor.fetchall()
    print("Top five most used words in 2023:", top_words_2023)

    # Query for top five most used words in 1982
    cursor.execute("""
        SELECT word, SUM(word_count) AS total_count
        FROM songs_words
        JOIN songs ON songs_words.song_title = songs.song_title
        WHERE song_year = 1982
        GROUP BY word
        ORDER BY total_count DESC
        LIMIT 5;
    """)
    top_words_1982 = cursor.fetchall()
    print("Top five most used words in 1982:", top_words_1982)

except Exception as e:
    print("An error occurred:", e)

finally:
    # Close the database connection
    if connection:
        cursor.close()
        connection.close()
        print("Database connection closed.")