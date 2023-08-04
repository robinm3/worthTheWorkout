import '../types/workout_types.dart';

class WorkoutService {
  const WorkoutService();

  Workout getDefaultWorkoutForMuscle(String id) {
    return workouts[0];
  }
}

const List<Workout> workouts = [
  Workout(
      name: "basic upper body",
      exercices: [pushUps, pullUps, pushUps, pullUps]),
  Workout(name: "basic lower body", exercices: [
    squats,
    lunges,
    squats,
    lunges,
  ]),
  Workout(name: "basic core", exercices: [
    crunches,
    lsits,
    crunches,
    lsits,
  ]),
];

Workout getWorkoutForMuscle(String label) {
  switch (label) {
    case "Upper Body":
      return workouts[0];
    case "Lower Body":
      return workouts[1];
    case "Core":
      return workouts[2];
    default:
      return workouts[0];
  }
}

const Exercice pushUps = Exercice(
  name: "Push ups",
  imageLink:
      "https://media1.popsugar-assets.com/files/thumbor/uP6p8lp2Yja1byH4vIVjfH3n-Cc=/fit-in/1584x1440/filters:format_auto():upscale()/2017/03/22/738/n/1922729/8589c22c445d63e2_0e7e9800cb65fd44_Tricep-Push-Up.jpg",
  timeForRep: 3,
  repCount: 10,
  setCount: 3,
  restTime: 60,
  toFailure: false,
  videoLink: "https://www.youtube.com/watch?v=9-DlYB4vO4U",
);

const Exercice pullUps = Exercice(
  name: "Pull ups",
  imageLink:
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.burnthefatinnercircle.com%2Fmembers%2Fimages%2F1930b.png&f=1&nofb=1&ipt=0a8deb2be1604c901b48a59d66d07845477964c265911b426f527324e90d2d26&ipo=images",
  timeForRep: 3,
  repCount: 10,
  setCount: 3,
  restTime: 60,
  toFailure: false,
  videoLink: "https://www.youtube.com/watch?v=IODxDxX7oi4",
);

const Exercice squats = Exercice(
  name: "Squats",
  imageLink:
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia1.popsugar-assets.com%2Ffiles%2Fthumbor%2FgjJt0kpxglD2UG_QZXoNDrNpl6A%2Ffit-in%2F2048xorig%2Ffilters%3Aformat_auto-!!-%3Astrip_icc-!!-%2F2020%2F05%2F07%2F844%2Fn%2F1922729%2Ftmp_M4k29K_aac9fae8e4fe86be_Mastering-Basic-Squat.jpg&f=1&nofb=1&ipt=648b4c2976264dd5b1f96edb3cd37d271dc0ca1da476f0631aa3391bbcf3f504&ipo=images",
  timeForRep: 3,
  repCount: 10,
  setCount: 3,
  restTime: 60,
  toFailure: false,
  videoLink: "https://www.youtube.com/watch?v=IODxDxX7oi4",
);

const Exercice lunges = Exercice(
  name: "Lunges",
  imageLink:
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fs-media-cache-ak0.pinimg.com%2Foriginals%2F1c%2F98%2F12%2F1c9812a3642e5a92e7bf59670d9d11ed.jpg&f=1&nofb=1&ipt=2856effbf2feef629f10772a4ab8195c45234421d402f261687474f9d0bc2d08&ipo=images",
  timeForRep: 10,
  repCount: 10,
  setCount: 3,
  restTime: 60,
  toFailure: false,
  videoLink: "https://www.youtube.com/watch?v=IODxDxX7oi4",
);

const Exercice crunches = Exercice(
  name: "Crunches",
  imageLink:
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia1.popsugar-assets.com%2Ffiles%2Fthumbor%2FeLb_6SzSGV2gwYQt8pHt11Amm6o%2Ffit-in%2F1024x1024%2Ffilters%3Aformat_auto-!!-%3Astrip_icc-!!-%2F2018%2F06%2F17%2F844%2Fn%2F40863086%2F19ffa4e7d608bff3_Basic-Crunch%2Fi%2FCrunches.jpg&f=1&nofb=1&ipt=731c2cee9cf56e1029e8290359277ae7aa76f40795d442764855b073662e307b&ipo=images",
  timeForRep: 10,
  repCount: 10,
  setCount: 3,
  restTime: 60,
  toFailure: false,
  videoLink: "https://www.youtube.com/watch?v=IODxDxX7oi4",
);

const Exercice lsits = Exercice(
  name: "L-sits",
  imageLink:
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpranayoga.co.in%2Fasana%2Fwp-content%2Fuploads%2FBramcharyasana-Celibates-pose-L-sit.jpg&f=1&nofb=1&ipt=31a79078800297af5df7c5b74d4ab2a1d6d9f22b1a092adfa2159f603c0a24e2&ipo=images",
  timeForRep: 60,
  repCount: 1,
  setCount: 3,
  restTime: 60,
  toFailure: false,
  videoLink: "https://www.youtube.com/watch?v=IODxDxX7oi4",
);
