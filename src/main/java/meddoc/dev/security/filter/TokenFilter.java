package meddoc.dev.security.filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Setter;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.security.service.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;
@Setter
@Component
public  class TokenFilter extends OncePerRequestFilter {
    @Autowired
    private JwtService jwtService;
    @Autowired
    private UserService userService;
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        final String authorizationHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            String token = authorizationHeader.substring(7);
            handleToken(token);
        }
        filterChain.doFilter(request, response);
    }
    protected void initializeUserContext(User user){
        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                user,
                null,
                user.getAuthorities()
        );
        SecurityContextHolder.getContext().setAuthentication(authToken);
    }
    protected void handleToken(String token) {
        String email = jwtService.extractUsername(token);
        User user =userService.findByEmail(email);
        if(jwtService.isTokenValid(token,user) && SecurityContextHolder.getContext().getAuthentication()==null){
            initializeUserContext(user);
        }
    }

}
