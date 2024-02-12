package meddoc.dev.notification;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.sql.Timestamp;
import java.util.List;
@Repository
public interface NotificationRepository extends JpaRepository<NotificationMessage, Integer> {
    @Query(value = "Select * from notification where created_at=?1", nativeQuery = true)
    List<NotificationMessage> findByCreated_at(Timestamp createdAt);
    @Query(value = "Select * from notification where user_id=?1  and seen_at is  null order by created_at ASC  ", nativeQuery = true)
    List<NotificationMessage> findByUser_id(int userId);
}
