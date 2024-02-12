package meddoc.dev.notification;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/notification")
public class NotificationController {
    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;
    @Autowired
    NotificationService notificationService;
    @Autowired
    UserService userService;
    @PutMapping("/seen/{event_id}")
    public ResponseEntity<String> seenNotification(@PathVariable int event_id){
        notificationService.seenNotif(event_id);
        return ResponseEntity.ok("ok");
    }
    @GetMapping
    public ResponseEntity<List<NotificationMessage>> getNotify(){
        User user=userService.getCurrentLoggedInUser();
        List<NotificationMessage> notificationMessages=notificationService.getByUser_id(user.getId());
        return ResponseEntity.ok(notificationMessages);
    }
    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    @GetMapping("/send/{userId}")
    public String sendMessageToUser(@PathVariable String userId) {
        messagingTemplate.convertAndSendToUser(userId, "/specific", "Hello, User!");
        return "Message sent to user with ID " + userId;
    }
}
