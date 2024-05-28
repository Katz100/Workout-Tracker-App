
function getWorkouts(day) {
    lm.clear()
    let workouts = Database.getWorkouts(day);

    for (let i = 0; i < workouts.length; i++) {
        lm.append(workouts[i]);
    }
}

function estimateWorkout(day) {
    let sets = Database.countSets(day);
    let rest = Database.findAverage(day);
    return sets * (rest/60);
}
