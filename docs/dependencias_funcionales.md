
### USERS

• id → nickname, email, payment_method, profile_picture, cellphone

### ADMINISTRATORS

• id → email

### GAME_STUDIOS

• nit → name, email

### GENRES

• id → name

### VIDEO_GAMES

• id → name, game_release_date, price, image, duration, status, ADMINISTRATORS_id

### STUDIOS_VIDEO_GAMES

• id → VIDEO_GAME_id, GAME_STUDIO_nit

### VIDEO_GAMES_GENRES

• id → VIDEO_GAMES_id, GENRES_id

• (VIDEO_GAMES_id, GENRES_id) → id

### LIBVIDEOS

• id → date, USER_ID, VIDEO_GAME_ID

• (USER_ID, VIDEO_GAME_ID) → id, date

### ACHIEVEMENTS

• id → description, VIDEO_GAME_ID

### LIB_ARCHIEVEMENTS

• id → unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id

• (ACHIEVEMENTS_id, LIBVIDEOS_id) → id, unlock_date

### STATISTICS

• id → period_start, period_end, hours_played, LIBVIDEO_id

• (LIBVIDEO_id, period_start) → id, period_end, hours_played

### COMMENTS

• id → message, USERS_ID, VIDEO_GAMES_id

• (USERS_ID, VIDEO_GAMES_id) → id, message
FRIENDSHIPS
• id → since_date, USERS_ID, USERS_FRIEND_ID
• (USERS_ID, USERS_FRIEND_ID) → id, since_date
