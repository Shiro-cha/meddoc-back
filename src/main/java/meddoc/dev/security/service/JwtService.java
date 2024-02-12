package meddoc.dev.security.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import java.security.Key;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.security.model.Jwt;
import meddoc.dev.security.repository.JwtRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
public class JwtService {
    @Value("${secret_key}")
    private String secretKey;
    private long jwtExpiration=60000000;
    @Autowired
    private JwtRepository jwtRepository;
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }
    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }
    public String generateToken(User user) {
        HashMap<String, Object> claims = new HashMap<>();
        claims.put("id",user.getId());
        if(user.getRole()!=null){
            claims.put("role",user.getRole().getName());
        }
        return generateToken(claims, user);
    }
    public void invalidateToken(String token,User user){
        isTokenValid(token,user);
        jwtRepository.expiredToken(token);
    }
    public String generateToken(
            Map<String, Object> extraClaims,
            User user
    ) {
        extraClaims.put("id",user.getId());
        if(user.getRole()!=null){
            extraClaims.put("role",user.getRole().getName());
        }
        Timestamp issueAtDate = new Timestamp(System.currentTimeMillis());
        Timestamp expirationDate = new Timestamp(issueAtDate.getTime() + jwtExpiration);
        String token=buildToken(extraClaims, user, issueAtDate,expirationDate);
        Jwt jwt = new Jwt(token,issueAtDate,expirationDate,user.getId());
        jwtRepository.save(jwt);
        return token;
    }
    private String buildToken(
            Map<String, Object> extraClaims,
            User user,
            Timestamp issuedAt,
            Timestamp expiration
    ) {
        return Jwts
                .builder()
                .setClaims(extraClaims)
                .setSubject(user.getUsername())
                .setIssuedAt(issuedAt)
                .setExpiration(expiration)
                .signWith(getSignInKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public boolean isTokenValid(String token,User user) {
        jwtRepository.getJwtByTokenAndUser(token,user.getId()).orElseThrow(()->new RuntimeException("Token Invalid!"));
        return true;
    }

    private Claims extractAllClaims(String token) {
        return Jwts
                .parserBuilder()
                .setSigningKey(getSignInKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
    private Key getSignInKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
