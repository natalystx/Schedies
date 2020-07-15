import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'

admin.initializeApp()

const db = admin.firestore()
const fcm = admin.messaging()

export const toSendTopic = functions.firestore
  .document('Events/${eventId}')
  .onCreate(async (snapshot) => {
    const event = snapshot.data()

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'New event coming',
        body: `You have new event is a ${event.topic}`,
        icon:
          'https://firebasestorage.googleapis.com/v0/b/schedie-2.appspot.com/o/logo.png?alt=media&token=1146c83c-bc87-4926-aa0f-4d09fa3816f9',
        clickAction: 'FLUTTER_NOTIFICATIONS_CLICK',
      },
    }
    let token: any = db
      .collection('Users data')
      .doc(`${event.sender}/fcmToken`)
      .onSnapshot((snapshots) => (token = snapshots.data()))

    return fcm.sendToDevice(token, payload)
  })
