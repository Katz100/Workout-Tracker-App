function getWorkouts(day) {
    lm.clear()
    let workouts = Database.getWorkouts(day);

    for (let i = 0; i < workouts.length; i++) {
        lm.append(workouts[i]);
    }
}
